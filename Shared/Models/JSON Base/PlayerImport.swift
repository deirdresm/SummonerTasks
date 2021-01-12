//
//  PlayerImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public class PlayerJsonWrapper {
    
    public var buildingInstanceCount = 0
    
    public init(json: String, docInfo: inout SummonerDocumentInfo) throws {
        var model:      String = ""
        var gameItems = 0
        var otherItems = 0
        var lastModel = ""
        
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
                let newSummoner = SummonerData(summoner: summoner, timezone: timezone)
                SummonerData.items.append(newSummoner)
                SummonerData.saveToCoreData(&docInfo)
                
                let buildingList = object.deco_list
                for item in buildingList {
                    let newBuilding = BuildingInstanceData(building: item)
                    BuildingInstanceData.items.append(newBuilding)
                }
                BuildingInstanceData.saveToCoreData(docInfo)

                let unitList = object.unit_list
                for item in unitList {
                    let newMonster = MonsterInstanceData(monster: item)
                    MonsterInstanceData.items.append(newMonster)
                    let count = MonsterInstanceData.items.count
                    if count % 100 == 0 {
                        print("imported \(count) monsters so far")
                    }
                }
                MonsterInstanceData.saveToCoreData(docInfo)

                let runes = object.runes
                for item in runes {
                    let newRune = RuneInstanceData(rune: item)
                    RuneInstanceData.items.append(newRune)
                }
                RuneInstanceData.saveToCoreData(docInfo)
           }
            catch let parseError {
                print("an uncaught error occurred: \(parseError)")
            }
            
            print("Total of \(BuildingInstanceData.items.count) building instances imported into \(self.buildingInstanceCount) rows")
            print("Total of \(MonsterInstanceData.items.count) monster instances imported")
            print("Total of \(RuneInstanceData.items.count) runes imported")
            print("Total of \(ArtifactInstanceData.items.count) artifacts imported")
        }


    }
}

