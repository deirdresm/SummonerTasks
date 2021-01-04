//
//  PlayerImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public class PlayerJsonWrapper {
    
    public var summonerData = [SummonerData]()
    public var buildingInstanceData = [BuildingInstanceData]()
    public var monsterInstanceData = [MonsterInstanceData]()
    public var runeInstanceData = [RuneInstanceData]()
    public var bestiarySkillData = [SkillData]()
    public var buildingInstanceCount = 0

    public init(json: String) throws {
        var model:      String
        var gameItems = 0
        var otherItems = 0
        var lastModel = ""
        
        // TODO: unlike the bestiary data, we have a few unfixed problems:
        
        // 1. not wrapped in model structure
        // 2. double array for rune skills
        // 3. entire file is NOT wrapped in array (so technically not well formed)

        print("trying to get JSON object")
        let object = try JSON(string: json)
        print("got JSON object, iterating through object")

        for item in object {
            model = item.model.string
            
            if model != lastModel {
                print("now parsing model \(model)")
                lastModel = model
            }
            
            if otherItems > 0 && (otherItems % 100 == 0) {
                print("parsed \(otherItems) other items")
            }

            switch model {
            case "wizard_info":
                let newSummoner = SummonerData(summoner: item)
                summonerData.append(newSummoner)
                print("imported \(summonerData.count) summoners so far") // should only be one
            case "deco_list":
                // buildings that affect stats
                let newBuilding = BuildingInstanceData(building: item)
                buildingInstanceData.append(newBuilding)
                print("imported \(buildingInstanceData.count) buildings so far")
            case "runes":
                // runes (including those not equipped)
                let newRune = RuneInstanceData(rune: item)
                runeInstanceData.append(newRune)
//            case "artifacts":
//                // runes (including those not equipped)
//                let newSkill = BestiarySkillData(skill: item, pk: pk)
//                bestiarySkillData.append(newSkill)
            case "defense_unit_list":
                otherItems += 1
            case "homunculus_skill_list":
                otherItems += 1
            case "unit_list":
                // start at line ???
                let newMonster = MonsterInstanceData(monster: item)
//                print(newMonster.name)
                monsterInstanceData.append(newMonster)
                let count = monsterInstanceData.count
                if count % 100 == 0 {
                    print("imported \(monsterInstanceData.count) monsters so far")
                }
            default:
                print("nope!")
            }
        }
        
        // time to do some insert/updates
        
        let taskContext = PersistenceController.shared.newTaskContext()

        taskContext.perform {
            BuildingInstance.batchUpdate(buildings: self.buildingInstanceData,
                                 context: taskContext)
            
            self.buildingInstanceCount = try! taskContext.count(for: BuildingInstance.fetchRequest())
            try! taskContext.save()
        }

        
        
        print("Ignored \(gameItems) game items")
        print("Total of \(buildingInstanceData.count) buildings imported into \(buildingInstanceCount) rows")
        print("Total of \(monsterInstanceData.count) monsters imported")
        print("Total of \(bestiarySkillData.count) monster skills imported")
        print("Total of \(otherItems) other items ignored")
    }
}

