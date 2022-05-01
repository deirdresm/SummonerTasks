//
//  BestiaryFileImport.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData
import OSLog

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
//		case fields
	}

	var pk: Int
	var modelName: String
	var managedObject: NSManagedObject
	var lastModelName: String

	init() {
		modelName = ""
		lastModelName = ""
		pk = 0

		managedObject = Building()
	}

	required convenience public init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)


		modelName = try container.decode(String.self, forKey: .modelName)
		pk = try container.decode(Int.self, forKey: .pk)
//		let item = try container.decode(String.self, forKey: .fields)

		// create the object

		switch self.modelName {
		case "bestiary.gameitem":
			managedObject = try decodeModel(of: GameItem.self, pk: self.pk, decoder: decoder)
		case "bestiary.building":
			managedObject = try decodeModel(of: Building.self, pk: self.pk, decoder: decoder)
		case "bestiary.source":
			managedObject =  try decodeModel(of: Source.self, pk: self.pk, decoder: decoder)
		case "bestiary.monster":
			managedObject = try decodeModel(of: Monster.self, pk: self.pk, decoder: decoder)
		case "bestiary.awakencost":
			managedObject = try decodeModel(of: AwakenCost.self, pk: self.pk, decoder: decoder)
		case "bestiary.monstercraftcost":
			managedObject = try decodeModel(of: MonsterCraftCost.self, pk: self.pk, decoder: decoder)
		case "bestiary.fusion":
			managedObject = try decodeModel(of: Fusion.self, pk: self.pk, decoder: decoder)
		case "bestiary.dungeon":
			managedObject = try decodeModel(of: Dungeon.self, pk: self.pk, decoder: decoder)
		case "bestiary.secretdungeon":
			managedObject = try decodeModel(of: SecretDungeon.self, pk: self.pk, decoder: decoder)
		case "bestiary.level":
			managedObject = try decodeModel(of: DungeonLevel.self, pk: self.pk, decoder: decoder)
		case "bestiary.wave":
			managedObject = try decodeModel(of: Wave.self, pk: self.pk, decoder: decoder)
		case "bestiary.enemy":
			managedObject = try decodeModel(of: Enemy.self, pk: self.pk, decoder: decoder)
		case "bestiary.skill":
			managedObject = try decodeModel(of: Skill.self, pk: self.pk, decoder: decoder)
		case "bestiary.skillupgrade":
			managedObject = try decodeModel(of: SkillUpgrade.self, pk: self.pk, decoder: decoder)
		case "bestiary.leaderskill":
			managedObject = try decodeModel(of: LeaderSkill.self, pk: self.pk, decoder: decoder)
		case "bestiary.skilleffect":
			managedObject = try decodeModel(of: SkillEffect.self, pk: self.pk, decoder: decoder)
		case "bestiary.skilleffectdetail":
			managedObject = try decodeModel(of: SkillEffectDetail.self, pk: self.pk, decoder: decoder)
		case "bestiary.scalingstat":
			managedObject = try decodeModel(of: ScalingStat.self, pk: self.pk, decoder: decoder)
		case "bestiary.homunculusskill":
			managedObject = try decodeModel(of: HomunculusSkill.self, pk: self.pk, decoder: decoder)
		case "bestiary.homunculusskillcraftcost":
			managedObject = try decodeModel(of: HomunculusSkillcraftCost.self, pk: self.pk, decoder: decoder)
		default:
			break
		}

	}

	func decodeModel<T: Decodable>(of type: T.Type, pk: Int, decoder: Decoder) throws -> T {
		let item: T = try T(from: decoder)
		return item
	}
}

//public class BestiaryFileImport: Decodable {
//
//	public var buildingCount = 0
//	public var monsterCount = 0
//	public var sourceCount = 0
//	public var leaderSkillCount = 0
//	public var skillCount = 0
//
//	var bestiaryItems: [BestiaryItem]
//
//	var logger: Logger
//
//	init() {
//		logger = Logger(subsystem: "net.deirdre.SummonerTasks", category: "bestiaryfileimport")
//		bestiaryItems = []
//	}
//
//	required convenience public init(from decoder: Decoder) throws {
//		self.init()
//		let text = Bundle.main.openBundleFile(from: "bestiary_data.json")
//
//		logger.debug("Starting bestiary import….")
//		try loadBestiaryData(json: text)
//	}
//
//	func loadBestiaryData(json: String) throws {
//
//
//
//	}
//	
//}


enum BestiaryFamily: String {
	typealias BaseType = NSManagedObject

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


