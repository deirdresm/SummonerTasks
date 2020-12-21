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

struct SummonerJsonDocument: FileDocument {
    
    // Since there can be different documents open for different summoners
    // keep the summoner in the Document class
    
    public var summonerObjectId: NSManagedObjectID?

    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.swExporterJsonFile] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            // TODO: cover more cases
            throw CocoaError(.fileReadCorruptFile)
        }
        
        do {
            // what we do depends on the filename
            
            guard let filename = configuration.file.filename else {
                throw CocoaError(.fileReadInvalidFileName)
            }
            
            if filename.contains("bestiary_data") {
                // bestiary_data.json - base bestiary data (changes rarely)
                
                // FIXME: move this to a background thread once we've got it sorted
                let url = URL(fileURLWithPath: filename)
                text = try String(contentsOf: url)
                let jsonWrapper = try BestiaryJsonWrapper(json: text)
                
                let buildingData = jsonWrapper.buildingData
            } else {
                // deirdresm-11223344.json - player save file (playername-com2usId.json)
    //            self = try JSONDecoder().decode(Self.self, from: data)
                let url = URL(fileURLWithPath: filename)
                text = try String(contentsOf: url)
                let jsonWrapper = try BestiaryJsonWrapper(json: text)

            }
         } catch {
            // TODO: cover more cases
            throw CocoaError(.fileReadCorruptFile)
        }
        
        text = ""
    }
    
    // we're only viewing files, but write configuration support is required
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
