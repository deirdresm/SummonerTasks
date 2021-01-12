//
//  BestiaryImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public class BestiaryJsonWrapper {
    
    public var buildingCount = 0
    public var monsterCount = 0
    public var sourceCount = 0
    public var leaderSkillCount = 0
    public var skillCount = 0
    
    public init(json: String, docInfo: SummonerDocumentInfo) throws {
        var model:      String = ""
        var pk:         Int64 = 0
        var gameItems = 0
        var otherItems = 0
        var lastModel = ""
        
        DispatchQueue.global(qos: .background).async {
            var object: JSON
            
            print("trying to get JSON object")
            do {
                object = try JSON(string: json)
                print("got JSON object, iterating through object")
                
                for item in object {
                    model = item.model.string
                    pk = item.pk.int
                    
                    if model != lastModel {
                        
                        switch lastModel {
                        case "bestiary.building":
                            BuildingData.saveToCoreData(docInfo)
                        case "bestiary.gameitem":
                            GameItemData.saveToCoreData(docInfo)
                        case "bestiary.source":
                            SourceData.saveToCoreData(docInfo)
                        case "bestiary.awakencost":
                            AwakenCostData.saveToCoreData(docInfo)
                        case "bestiary.monstercraftcost":
                            MonsterCraftCostData.saveToCoreData(docInfo)
                        // bestiary.monstercraftcost goes here
                        case "bestiary.fusion":
                            FusionData.saveToCoreData(docInfo)
                        case "bestiary.skill":
                            SkillData.saveToCoreData(docInfo)
                        case "bestiary.skillupgrade":
                            SkillUpgradeData.saveToCoreData(docInfo)
                        case "bestiary.leaderskill":
                            LeaderSkillData.saveToCoreData(docInfo)
                        case "bestiary.skilleffect":
                            SkillEffectData.saveToCoreData(docInfo)
                        case "bestiary.skilleffectdetail":
                            SkillEffectDetailData.saveToCoreData(docInfo)
                        case "bestiary.scalingstat":
                            ScalingStatData.saveToCoreData(docInfo)
                        case "bestiary.homunculusskill":
                            HomunculusSkillData.saveToCoreData(docInfo)
                        case "bestiary.homunculusskillcraftcost":
                            HomunculusSkillcraftData.saveToCoreData(docInfo)
                        case "bestiary.monster":
                            MonsterData.saveToCoreData(docInfo)
                        default:
                            lastModel = model
                        }
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
                        BuildingData.items.append(newBuilding)
                    case "bestiary.gameitem":
                        // start at line 1
                        let newGameItem = GameItemData(gameItem: item, pk: pk)
                        GameItemData.items.append(newGameItem)
                    case "bestiary.source":
                        // start at line 1531
                        let newSource = SourceData(source: item, pk: pk)
                        SourceData.items.append(newSource)
                    case "bestiary.awakencost":
                        let newAwakenCost = AwakenCostData(awaken: item, pk: pk)
                        AwakenCostData.items.append(newAwakenCost)
                    case "bestiary.monstercraftcost":
                        let newMonsterCraftCost = MonsterCraftCostData(monsterCraft: item, pk: pk)
                        MonsterCraftCostData.items.append(newMonsterCraftCost)
                    case "bestiary.dungeon",
                         "bestiary.secretdungeon",
                         "bestiary.level",
                         "bestiary.wave",
                         "bestiary.enemy":
                        otherItems += 1
                    case "bestiary.fusion":
                        let newFusion = FusionData(fusion: item, pk: pk)
                        FusionData.items.append(newFusion)
                    case "bestiary.skill":
                        let newSkill = SkillData(skill: item, pk: pk)
                        SkillData.items.append(newSkill)
                    case "bestiary.skillupgrade":
                        let newSkill = SkillUpgradeData(skillUpgrade: item, pk: pk)
                        SkillUpgradeData.items.append(newSkill)
                    case "bestiary.leaderskill":
                        let newSkill = LeaderSkillData(skill: item, pk: pk)
                        LeaderSkillData.items.append(newSkill)
                    case "bestiary.skilleffect":
                        let newSkill = SkillEffectData(skillEffect: item, pk: pk)
                        SkillEffectData.items.append(newSkill)
                    case "bestiary.skilleffectdetail":
                        let newSkill = SkillEffectDetailData(skillEffectDetail: item, pk: pk)
                        SkillEffectDetailData.items.append(newSkill)
                    case "bestiary.scalingstat":
                        let newScalingStat = ScalingStatData(scalingStat: item, pk: pk)
                        ScalingStatData.items.append(newScalingStat)
                    case "bestiary.homunculusskill":
                        let newHomuSkill = HomunculusSkillData(homunculusSkill: item, pk: pk)
                        HomunculusSkillData.items.append(newHomuSkill)
                    case "bestiary.homunculusskillcraftcost":
                        let newHomuSkillcraft = HomunculusSkillcraftData(homunculusSkill: item, pk: pk)
                        HomunculusSkillcraftData.items.append(newHomuSkillcraft)
                    case "bestiary.monster":
                        // start at line ???
                        let newMonster = MonsterData(monster: item, pk: pk)
                        //                print(newMonster.name)
                        MonsterData.items.append(newMonster)
                        let count = MonsterData.items.count
                        
                        // TODO: refactor so it's saving periodically
                        if count % 100 == 0 {
                            print("imported \(MonsterData.items.count) monsters so far")
                        }
                    default:
                        print("nope!")
                    } // switch
                } // if
            }
            catch let parseError {
                print("an uncaught error occurred: \(parseError)")
            }
            
            print("Ignored \(gameItems) game items")
            print("Total of \(BuildingData.items.count) buildings imported into \(self.buildingCount) rows")
            print("Total of \(SourceData.items.count) bestiary sources imported")
            print("Total of \(MonsterData.items.count) monsters imported into \(self.monsterCount) rows")
            print("Total of \(SkillData.items.count) monster skills imported")
            print("Total of \(otherItems) other items ignored")
        }
    }
}

