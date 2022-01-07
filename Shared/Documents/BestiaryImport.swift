//
//  BestiaryFileImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

/*
 [
	 {
		 "model": "bestiary.gameitem",
		 "pk": 1,
		 "fields": {
			 "com2us_id": 2,
			 "category": 6,
			 "name": "Social Point",
			 "icon": "social.png",
			 "description": "",
			 "slug": "social-point",
			 "sell_value": null
		 }
	 },
 ]
*/

public class BestiaryItem: Decodable {
	public enum CodingKeys: String, CodingKey {
		case modelName = "model"
		case pk
		case fields
	}

	public enum ModelKeys: String, CodingKey {
		case gameItem = "bestiary.gameitem"
		case building = "bestiary.building"
		case itemSource = "bestiary.source"
		case monster = "bestiary.monster"
		case awakenCost = "bestiary.awakencost"
		case monsterCraftCost = "bestiary.monstercraftcost"
		case fusion = "bestiary.fusion"
		case dungeon = "bestiary.dungeon"
		case secretDungeon = "bestiary.secretdungeon"
		case dungeonLevel = "bestiary.level"
		case wave = "bestiary.wave"
		case enemy = "bestiary.enemy"
		case skill = "bestiary.skill"
		case skillUpgrade = "bestiary.skillupgrade"
		case leaderSkill = "bestiary.leaderskill"
		case skillEffect = "bestiary.skilleffect"
		case skillEffectDetail = "bestiary.skilleffectdetail"
		case scalingStat = "bestiary.scalingstat"
		case homunculusSkill = "bestiary.homunculusskill"
		case homunculusSkillcraftCost = "bestiary.homunculusskillcraftcost"

		func getType() -> Decodable.Type {
			switch self {
			case .gameItem:
				return GameItem.self
			case .building:
				return Building.self
			case .itemSource:
				return Source.self
			case .monster:
				return Monster.self
			case .awakenCost:
				return AwakenCost.self
			case .monsterCraftCost:
				return MonsterCraftCost.self
			case .fusion:
				return Fusion.self
			case .dungeon:
				return Dungeon.self
			case .secretDungeon:
				return SecretDungeon.self
			case .dungeonLevel:
				return DungeonLevel.self
			case .wave:
				return Wave.self
			case .enemy:
				return Enemy.self
			case .skill:
				return Skill.self
			case .skillUpgrade:
				return SkillUpgrade.self
			case .leaderSkill:
				return LeaderSkill.self
			case .skillEffect:
				return SkillEffect.self
			case .skillEffectDetail:
				return SkillEffectDetail.self
			case .scalingStat:
				return ScalingStat.self
			case .homunculusSkill:
				return HomunculusSkill.self
			case .homunculusSkillcraftCost:
				return HomunculusSkillcraftCost.self
			}
		}
	}

	var modelName: String = ""
	var pk: Int = 0
	var fields: Dictionary<String, AnyObject>

	init() {
		modelName = ""
		pk = 0
		fields = Dictionary()
	}

	required convenience public init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.modelName = try container.decode(String.self, forKey: .modelName)
		self.pk = try container.decode(Int.self, forKey: .pk)
		let fields = try container.decode(String.self, forKey: .fields)
	}
}

public class BestiaryFileImport: Decodable {

	public var buildingCount = 0
	public var monsterCount = 0
	public var sourceCount = 0
	public var leaderSkillCount = 0
	public var skillCount = 0

	required convenience public init(from decoder: Decoder) throws {
		var model:      String = ""
		var pk:         Int64 = 0
		var gameItems = 0
		var otherItems = 0
		var lastModel = ""

		self.init()
		print("Bestiary file import starting")


//        DispatchQueue.global(qos: .background).async {
//			let unkeyedWrapper = decoder.unkeyedContainer() // outer array
//
//            print("trying to get JSON object")
//            do {
//                object = try JSON(string: json)
//                print("got JSON object, iterating through object")
//
//                for item in object {
//                    model = item.model.string
//                    pk = item.pk.int
//
//                    if model != lastModel {
//						print("now parsing model \(model)")
//                        lastModel = model
//                    }
//
//                    if otherItems > 0 && (otherItems % 100 == 0) {
//                        print("parsed \(otherItems) other items")
//                    }
//
//                    switch model {
//                    case "bestiary.building":
//                        // start at line 1212
//                        let newBuilding = BuildingData(building: item, pk: pk)
//                        BuildingData.items.append(newBuilding)
//                    case "bestiary.gameitem":
//                        // start at line 1
//                        let newGameItem = GameItemData(gameItem: item, pk: pk)
//                        GameItemData.items.append(newGameItem)
//                    case "bestiary.source":
//                        // start at line 1531
//                        let newSource = SourceData(source: item, pk: pk)
//                        SourceData.items.append(newSource)
//                    case "bestiary.awakencost":
//                        let newAwakenCost = AwakenCostData(awaken: item, pk: pk)
//                        AwakenCostData.items.append(newAwakenCost)
//                    case "bestiary.monstercraftcost":
//                        let newMonsterCraftCost = MonsterCraftCostData(monsterCraft: item, pk: pk)
//                        MonsterCraftCostData.items.append(newMonsterCraftCost)
//                    case "bestiary.dungeon",
//                         "bestiary.secretdungeon",
//                         "bestiary.level",
//                         "bestiary.wave",
//                         "bestiary.enemy":
//                        otherItems += 1
//                    case "bestiary.fusion":
//                        let newFusion = FusionData(fusion: item, pk: pk)
//                        FusionData.items.append(newFusion)
//                    case "bestiary.skill":
//                        let newSkill = SkillData(skill: item, pk: pk)
//                        SkillData.items.append(newSkill)
//                    case "bestiary.skillupgrade":
//                        let newSkill = SkillUpgradeData(skillUpgrade: item, pk: pk)
//                        SkillUpgradeData.items.append(newSkill)
//                    case "bestiary.leaderskill":
//                        let newSkill = LeaderSkillData(skill: item, pk: pk)
//                        LeaderSkillData.items.append(newSkill)
//                    case "bestiary.skilleffect":
//                        let newSkill = SkillEffectData(skillEffect: item, pk: pk)
//                        SkillEffectData.items.append(newSkill)
//                    case "bestiary.skilleffectdetail":
//                        let newSkill = SkillEffectDetailData(skillEffectDetail: item, pk: pk)
//                        SkillEffectDetailData.items.append(newSkill)
//                    case "bestiary.scalingstat":
//                        let newScalingStat = ScalingStatData(scalingStat: item, pk: pk)
//                        ScalingStatData.items.append(newScalingStat)
//                    case "bestiary.homunculusskill":
//                        let newHomuSkill = HomunculusSkillData(homunculusSkill: item, pk: pk)
//                        HomunculusSkillData.items.append(newHomuSkill)
//                    case "bestiary.homunculusskillcraftcost":
//                        let newHomuSkillcraft = HomunculusSkillcraftData(homunculusSkill: item, pk: pk)
//                        HomunculusSkillcraftData.items.append(newHomuSkillcraft)
//                    case "bestiary.monster":
//                        // start at line ???
//                        let newMonster = MonsterData(monster: item, pk: pk)
//                        //                print(newMonster.name)
//                        MonsterData.items.append(newMonster)
//                        let count = MonsterData.items.count
//
//                        // TODO: refactor so it's saving periodically
//                        if count % 100 == 0 {
//                            print("imported \(MonsterData.items.count) monsters so far")
//                        }
//                    default:
//                        print("nope!")
//                    } // switch
//                } // if
//            }
//            catch let parseError {
//                print("an uncaught error occurred: \(parseError)")
//            }
//		}
	}
}




enum BestiaryFamily: String {
	typealias BaseType = Decodable

	case gameItem = "bestiary.gameitem"
	case building = "bestiary.building"
	case itemSource = "bestiary.source"
	case monster = "bestiary.monster"
	case awakenCost = "bestiary.awakencost"
	case monsterCraftCost = "bestiary.monstercraftcost"
	case fusion = "bestiary.fusion"
	case dungeon = "bestiary.dungeon"
	case secretDungeon = "bestiary.secretdungeon"
	case dungeonLevel = "bestiary.level"
	case wave = "bestiary.wave"
	case enemy = "bestiary.enemy"
	case skill = "bestiary.skill"
	case skillUpgrade = "bestiary.skillupgrade"
	case leaderSkill = "bestiary.leaderskill"
	case skillEffect = "bestiary.skilleffect"
	case skillEffectDetail = "bestiary.skilleffectdetail"
	case scalingStat = "bestiary.scalingstat"
	case homunculusSkill = "bestiary.homunculusskill"
	case homunculusSkillcraftCost = "bestiary.homunculusskillcraftcost"

	func getType() -> Decodable.Type {
		switch self {
		case .gameItem:
			return GameItem.self
		case .building:
			return Building.self
		case .itemSource:
			return Source.self
		case .monster:
			return Monster.self
		case .awakenCost:
			return AwakenCost.self
		case .monsterCraftCost:
			return MonsterCraftCost.self
		case .fusion:
			return Fusion.self
		case .dungeon:
			return Dungeon.self
		case .secretDungeon:
			return SecretDungeon.self
		case .dungeonLevel:
			return DungeonLevel.self
		case .wave:
			return Wave.self
		case .enemy:
			return Enemy.self
		case .skill:
			return Skill.self
		case .skillUpgrade:
			return SkillUpgrade.self
		case .leaderSkill:
			return LeaderSkill.self
		case .skillEffect:
			return SkillEffect.self
		case .skillEffectDetail:
			return SkillEffectDetail.self
		case .scalingStat:
			return ScalingStat.self
		case .homunculusSkill:
			return HomunculusSkill.self
		case .homunculusSkillcraftCost:
			return HomunculusSkillcraftCost.self
		}
	}
}

extension Encodable {
	fileprivate func encode(to container: inout SingleValueEncodingContainer) throws {
		try container.encode(self)
	}
}

extension Decodable {
	public static func decode<Container: SingleValueDecodingContainer>(from container: Container) throws -> Self {
		return try container.decode(Self.self)
	}
}


