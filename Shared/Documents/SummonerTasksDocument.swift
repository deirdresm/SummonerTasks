//
//  SummonerJsonDocument.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine

extension UTType {
    static var swExporterJsonFile: UTType {
        UTType(importedAs: "public.json")
    }
}

public class SummonerDocumentInfo {
    public var summoner: Summoner?
    public var summonerId: Int64 = 0
    public var summonerSet = false
    public var taskContext: NSManagedObjectContext
    
    public init() {
        taskContext = PersistenceController.shared.newTaskContext()
    }
}

class BestiaryDocument: FileDocument {
	static var readableContentTypes: [UTType] { [.json] }

	required init(configuration: ReadConfiguration) throws {
		<#code#>
	}

	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		<#code#>
	}


}

class SummonerJsonDocument: FileDocument {
    
    // Since there can be different documents open for different summoners
    // keep the summoner in the Document class
    
    public var summonerObjectId: NSManagedObjectID? // for passing between threads
    @Published var docInfo = SummonerDocumentInfo()

    var text: String = ""

    static var readableContentTypes: [UTType] { [.json] }
    
    // added second param for previews and testing
    init(text: String = "Hello, world!", summoner: Summoner? = nil, isPreview: Bool = false) throws {
        self.text = text
        
        if let s = summoner {
            docInfo.summoner = s
            docInfo.summonerId = s.id
            docInfo.summonerSet = true
        }
        
        print("trying bestiary json wrapper)")
        let jsonWrapper = try BestiaryFileImport(json: text, docInfo: docInfo)
        
//        let buildingData = BuildingData.items
//        print("buildingData count = \(buildingData.count)")
    }
    
    func loadBestiaryData() throws {
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: docInfo)
        
//        let buildingData = BuildingData.items
    }

    func loadPlayerData(json: String) throws {
        // TODO: unlike the bestiary data, we have a few unfixed problems:
        
        // 1. double array for rune skills

        print("created task context")
        DispatchQueue.global(qos: .background).async {
//            var object: JSON
            var data: Data = json.data(using: .utf8)! // non-nil

            do {
                print("trying to get JSON object")
//                object = try JSON(string: json)
                let decoder = JSONDecoder()
                print("got JSON object, iterating through object")
                decoder.userInfo[CodingUserInfoKey.context!] = self.docInfo.taskContext
                decoder.dateDecodingStrategy = .formatted(DateFormatter.com2us)

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
            if filename.contains("bestiary_data") {
                // bestiary_data.json - base bestiary data (changes rarely)
                
                print("Loading bestiary data.")
                let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: self.docInfo)
                
                let buildingData = BuildingData.items
            } else {
                // deirdresm-11223344.json - player save file (playername-com2usId.json)
 
                print("Loading player file.")
                try loadPlayerData(json: text)

            }
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
