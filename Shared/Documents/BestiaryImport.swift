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


