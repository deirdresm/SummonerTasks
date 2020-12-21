//
//  BestiaryImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation

public class BestiaryJsonWrapper {
    
    public var buildingData = [BuildingData]()
    public var monsterData = [MonsterData]()
    public var sourceData = [SourceData]()
    public var bestiarySkillData = [BestiarySkillData]()
    public var buildingCount = 0

    public init(json: String) throws {
        var model:      String
        var pk:         Int64
        var gameItems = 0
        var otherItems = 0
        var lastModel = ""

        print("trying to get JSON object")
        let object = try JSON(string: json)
        print("got JSON object, iterating through object")

        for item in object {
            model = item.model.string
            pk = item.pk.int
            
            if model != lastModel {
                print("now parsing model \(model)")
                lastModel = model
            }
            
            if otherItems > 0 && (otherItems % 100 == 0) {
                print("parsed \(otherItems) other items")
            }

            switch model {
            case "bestiary.building":
                // start at line 1212
                let newBuilding = BuildingData(building: item, pk: pk)
                print(newBuilding.name)
                buildingData.append(newBuilding)
                print("imported \(buildingData.count) buildings so far")
            case "bestiary.gameitem":
                // start at line 1
                gameItems += 1
            case "bestiary.source":
                // start at line 1531
                let newSource = SourceData(source: item, pk: pk)
                sourceData.append(newSource)
            case "bestiary.awakencost",
                 "bestiary.monstercraftcost",
                 "bestiary.dungeon",
                 "bestiary.secretdungeon",
                 "bestiary.level",
                 "bestiary.wave",
                 "bestiary.enemy":
                otherItems += 1
            case "bestiary.fusion":
                otherItems += 1
            case "bestiary.skill":
                let newSkill = BestiarySkillData(skill: item, pk: pk)
                bestiarySkillData.append(newSkill)
            case "bestiary.skillupgrade":
                otherItems += 1
            case "bestiary.leaderskill":
                otherItems += 1
            case "bestiary.skilleffect":
                otherItems += 1
            case "bestiary.skilleffectdetail":
                otherItems += 1
            case "bestiary.scalingstat":
                otherItems += 1
            case "bestiary.homunculusskill":
                otherItems += 1
            case "bestiary.homunculusskillcraftcost":
                otherItems += 1
            case "bestiary.monster":
                // start at line ???
                let newMonster = MonsterData(monster: item, pk: pk)
//                print(newMonster.name)
                monsterData.append(newMonster)
                let count = monsterData.count
                if count % 100 == 0 {
                    print("imported \(monsterData.count) monsters so far")
                }
            default:
                print("nope!")
            }
        }
        
        // time to do some insert/updates
        
        let taskContext = PersistenceController.shared.newTaskContext()

        taskContext.perform {
            Building.batchUpdate(buildings: self.buildingData,
                                 context: taskContext)
            
            self.buildingCount = try! taskContext.count(for: Building.fetchRequest())
            try! taskContext.save()
        }

        
        
        print("Ignored \(gameItems) game items")
        print("Total of \(buildingData.count) buildings imported into \(buildingCount) rows")
        print("Total of \(sourceData.count) bestiary sources imported")
        print("Total of \(monsterData.count) monsters imported")
        print("Total of \(bestiarySkillData.count) monster skills imported")
        print("Total of \(otherItems) other items ignored")
    }
}

