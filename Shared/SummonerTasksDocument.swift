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

class SummonerJsonDocument: FileDocument {
    
    // Since there can be different documents open for different summoners
    // keep the summoner in the Document class
    
    public var summonerObjectId: NSManagedObjectID? // for passing between threads
    @Published var docInfo = SummonerDocumentInfo()

    var text: String = ""

    static var readableContentTypes: [UTType] { [.json] }
    
    // added second param for previews and testing
    init(text: String = "Hello, world!", summoner: Summoner? = nil) throws {
        self.text = text
        
        if let s = summoner {
            docInfo.summoner = s
            docInfo.summonerId = s.id
            docInfo.summonerSet = true
        }
        
        print("trying bestiary json wrapper)")
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: docInfo)
        
        let buildingData = BuildingData.items
        print("buildingData count = \(buildingData.count)")
    }
    
    func loadBestiaryData() throws {
        let jsonWrapper = try BestiaryJsonWrapper(json: text, docInfo: docInfo)
        
//        let buildingData = BuildingData.items
    }

    func loadPlayerData(json: String) throws {
        // TODO: unlike the bestiary data, we have a few unfixed problems:
        
        // 1. not wrapped in model structure
        // 2. double array for rune skills
        // 3. entire file is NOT wrapped in array (so technically not well formed)

        print("created task context")
        DispatchQueue.global(qos: .background).async {
            var object: JSON

            do {
                print("trying to get JSON object")
                object = try JSON(string: json)
                print("got JSON object, iterating through object")

                let summoner = object.wizard_info
                let timezone = object.tzone
                let newSummoner = SummonerData(summoner: summoner, tzone: timezone)
                SummonerData.items.append(newSummoner)
                SummonerData.saveToCoreData(&self.docInfo)

                let buildingList = object.deco_list
                for item in buildingList {
                    let newBuilding = BuildingInstanceData(building: item)
                    BuildingInstanceData.items.append(newBuilding)
                }
                BuildingInstanceData.saveToCoreData(self.docInfo)
                print("Total of \(summoner.buildings.count) building instances imported")
                
                let unitList = object.unit_list
                print("unit list count = \(unitList.count)")
                for item in unitList {
                    let newMonster = MonsterInstanceData(monster: item)
                    MonsterInstanceData.items.append(newMonster)
                    let count = MonsterInstanceData.items.count
                    if count % 100 == 0 {
                        print("imported \(count) monsters so far")
                    }
                }
                MonsterInstanceData.saveToCoreData(self.docInfo)

                let runes = object.runes
                for item in runes {
                    let newRune = RuneInstanceData(rune: item)
                    RuneInstanceData.items.append(newRune)
                }
                RuneInstanceData.saveToCoreData(self.docInfo)

                let artifacts = object.artifacts
                for item in artifacts {
                    let newArtifact = ArtifactInstanceData(artifact: item)
                    ArtifactInstanceData.items.append(newArtifact)
                }
                ArtifactInstanceData.saveToCoreData(self.docInfo)
                
                print("Total of \(MonsterInstanceData.items.count) monster instances imported")
                print("Total of \(RuneInstanceData.items.count) runes imported")
                print("Total of \(ArtifactInstanceData.items.count) artifacts imported")
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
