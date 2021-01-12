//
//  SummonerJsonDocument.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var swExporterJsonFile: UTType {
        UTType(importedAs: "public.json")
    }
}

public struct SummonerDocumentInfo {
    public var summoner: Summoner?
    public var summonerSet = false
    public var taskContext: NSManagedObjectContext
    
    public init() {
        taskContext = PersistenceController.shared.newTaskContext()
    }
}

struct SummonerJsonDocument: FileDocument {
    
    // Since there can be different documents open for different summoners
    // keep the summoner in the Document class
    
    public var summonerObjectId: NSManagedObjectID? // for passing between threads
    var docInfo = SummonerDocumentInfo()

    var text: String = ""

    static var readableContentTypes: [UTType] { [.json] }
    
    init(text: String = "Hello, world!") throws {
        self.text = text
        
        print("trying bestiary json wrapper)")
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: self.docInfo)
        
        let buildingData = BuildingData.items
        print("buildingData count = \(buildingData.count)")
    }
    
    func loadBestiaryData() throws {
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: self.docInfo)
        
        let buildingData = BuildingData.items

    }

    func loadPlayerData() throws {
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: self.docInfo)
    }

    public init(configuration: ReadConfiguration) throws {
        
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
                
                print("Sucked in bestiary data.")
                let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: self.docInfo)
                
                let buildingData = BuildingData.items
            } else {
                // deirdresm-11223344.json - player save file (playername-com2usId.json)
 
                print("Trying to read player file.")
                let jsonWrapper = try PlayerJsonWrapper(json: text, docInfo: self.docInfo)

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
