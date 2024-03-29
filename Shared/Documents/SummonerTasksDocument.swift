//
//  SummonerJsonDocument.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine
import OSLog

public class SummonerDocumentInfo {
    public var summoner: Summoner?
    public var summonerId: Int64 = 0
    public var summonerSet = false
    public var taskContext: NSManagedObjectContext
    
	public init(_ context: NSManagedObjectContext?) {
		taskContext = context ?? Persistence.shared.newTaskContext()
    }
}

class SWDocument: FileDocument {
    
    // Since there can be different documents open for different summoners
    // keep the summoner in the Document class
    
    public var summonerObjectId: NSManagedObjectID? // for passing between threads
    @Published var docInfo = SummonerDocumentInfo(Persistence.shared.newTaskContext())

    var text: String = ""

	var logger: Logger

    static var readableContentTypes: [UTType] { [.json] }
    
    // added second param for previews and testing
    init(text: String = "Hello, world!", summoner: Summoner? = nil, isPreview: Bool = false) throws {
        self.text = text
		logger = Logger(subsystem: "net.deirdre.SummonerTasks", category: "summonerImpoprt")
        
        if let s = summoner {
            docInfo.summoner = s
            docInfo.summonerId = s.id
            docInfo.summonerSet = true
        }
	}
    
    func loadPlayerData(json: String) throws {
        // TODO: unlike the bestiary data, we have a few unfixed problems:
        
        // 1. double array for rune skills

        print("created task context")
        DispatchQueue.global(qos: .background).async {
            let data: Data = json.data(using: .utf8)! // non-nil

            do {
                print("trying to get JSON object")
                let decoder = JSONDecoder()
                print("got JSON object, iterating through object")
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.docInfo.taskContext
                decoder.dateDecodingStrategy = .formatted(DateFormatter.com2us)
				decoder.keyDecodingStrategy = .convertFromSnakeCase

                let container = try decoder.decode(PlayerFile.self, from: data)

				// save context

				self.docInfo.taskContext.perform {

					// save first to make sure we've got a full house

					do {
						if self.docInfo.taskContext.hasChanges {
							try self.docInfo.taskContext.save()
						}

					} catch {
						print("could not save context")
					}
				}
           }
            catch let parseError {
                print("an uncaught error occurred: \(parseError)")
            }
        }
    }

    required public init(configuration: ReadConfiguration) throws {
		logger = Logger(subsystem: "net.deirdre.SummonerTasks", category: "summonerImpoprt")

 //       self.config = configuration
        
        do {
            // what we do depends on the filename
            
            guard let data = configuration.file.regularFileContents else {
                // TODO: cover more cases
                throw CocoaError(.fileReadCorruptFile)
            }
            
            text = String(decoding: data, as: UTF8.self)
            
            guard let filename = configuration.file.filename else {
                throw CocoaError(.fileReadInvalidFileName)
            }
			print("Loading player file.")
			try loadPlayerData(json: text)
         } catch {
            // TODO: cover more cases
            throw CocoaError(.fileReadCorruptFile)
        }
        
        text = ""
    }
    
    // we're only viewing files, but write configuration support is required
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw JSONFileError.notImplemented
    }
}

enum JSONFileError: Error
{
    case notImplemented
}
