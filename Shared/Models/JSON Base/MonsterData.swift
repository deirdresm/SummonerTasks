//
//  MonsterData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/14/20.
//

import Foundation
import CoreData

public struct MonsterData: JsonArray {

	static var items = [MonsterData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case name
		case com2usId = "com2us_id"
		case familyId
		case imageFilename
		case element
		case archetype
		case baseStars
		case obtainable
		case canAwaken
		case isAwakened
		case awakenLevel
		case awakenBonus
		case skillUpsToMax
		case leaderSkill
		case rawHp
		case rawAttack
		case rawDefense
		case baseHp
		case baseAttack
		case baseDefense
		case maxLvlHp
		case maxLvlAttack
		case maxLvlDefense
		case speed
		case critRate
		case critDamage
		case resistance
		case accuracy
		case homunculus
		case craftCost
		case transformsToId = "transforms_to"

		case awakenMatsFireLow
		case awakenMatsFireMid
		case awakenMatsFireHigh

		case awakenMatsWaterLow
		case awakenMatsWaterMid
		case awakenMatsWaterHigh

		case awakenMatsWindLow
		case awakenMatsWindMid
		case awakenMatsWindHigh

		case awakenMatsLightLow
		case awakenMatsLightMid
		case awakenMatsLightHigh

		case awakenMatsDarkLow
		case awakenMatsDarkMid
		case awakenMatsDarkHigh

		case awakenMatsMagicLow
		case awakenMatsMagicMid
		case awakenMatsMagicHigh

		case farmable
		case fusionFood
		case bestiarySlug
		case awakensFromId
		case awakensToId
		case leaderSkillId
		case naturalStars
	}

	let id:             Int64
	let name:           String
	let com2usId:       Int64
	let familyId:       Int64?
	let imageFilename:  String?
	let element:        String?
	let archetype:      String?
	let baseStars:      Int16
	var naturalStars:   Int16 = 1
	let obtainable:     Bool
	let canAwaken:      Bool
	let isAwakened:     Bool
	var awakenLevel:    Int16 = 0
	let awakenBonus:    String
	let awakensFromId:  Int64?
	let awakensToId:    Int64?
	let skillUpsToMax:  Int64?
	let leaderSkill:    Int64?
	let rawHp:          Int64?
	let rawAttack:      Int64?
	let rawDefense:     Int64?
	let baseHp:         Int64?
	let baseAttack:     Int64?
	let baseDefense:    Int64?
	let maxLvlHp:       Int64?
	let maxLvlAttack:   Int64?
	let maxLvlDefense:  Int64?
	let speed:          Int64?
	let critRate:       Int64?
	let critDamage:     Int64?
	let resistance:     Int64?
	let accuracy:       Int64?
	var homunculus:     Bool = false
	let craftCost:      Int64?
	let transformsToId:         Int64?

	var awakenMatsFireLow:    Int16 = 0
	var awakenMatsFireMid:    Int16 = 0
	var awakenMatsFireHigh:   Int16 = 0

	var awakenMatsWaterLow:   Int16 = 0
	var awakenMatsWaterMid:   Int16 = 0
	var awakenMatsWaterHigh:  Int16 = 0

	var awakenMatsWindLow:    Int16 = 0
	var awakenMatsWindMid:    Int16 = 0
	var awakenMatsWindHigh:   Int16 = 0

	var awakenMatsLightLow:   Int16 = 0
	var awakenMatsLightMid:   Int16 = 0
	var awakenMatsLightHigh:  Int16 = 0

	var awakenMatsDarkLow:    Int16 = 0
	var awakenMatsDarkMid:    Int16 = 0
	var awakenMatsDarkHigh:   Int16 = 0

	var awakenMatsMagicLow:   Int16 = 0
	var awakenMatsMagicMid:   Int16 = 0
	var awakenMatsMagicHigh:  Int16 = 0

	var farmable:             Bool = true
	var fusionFood:           Bool = false
	var bestiarySlug:         String?
	var skills:               [Int64]
	var source:               [Int64]


	public init(monster: JSON, pk: Int64) {
		id = monster.pk.int
		name = monster.fields.name.string
		com2usId = monster.fields.com2us_id.int
		familyId = monster.fields.family_id.int
		imageFilename = monster.fields.image_filename.string
		element = monster.fields.element.optionalString
		archetype = monster.fields.archetype.optionalString
		baseStars = monster.fields.base_stars.int16
		naturalStars = monster.fields.natural_stars.int16
		obtainable = monster.fields.obtainable.bool
		canAwaken = monster.fields.can_awaken.bool
		isAwakened = monster.fields.is_awakened.bool
		awakenLevel = monster.fields.awaken_level.int16
		awakenBonus = monster.fields.awaken_bonus.string
		awakensToId = monster.fields.awakens_to.optionalInt
		awakensFromId = monster.fields.awakens_from.optionalInt
		skillUpsToMax = monster.fields.skill_ups_to_max.optionalInt
		leaderSkill = monster.fields.leader_skill.optionalInt
		rawHp = monster.fields.raw_hp.int
		rawAttack = monster.fields.raw_attack.int
		rawDefense = monster.fields.raw_defense.int
		baseHp = monster.fields.base_hp.int
		baseAttack = monster.fields.base_attack.int
		baseDefense = monster.fields.base_defense.int
		maxLvlHp = monster.fields.max_lvl_hp.optionalInt
		maxLvlAttack = monster.fields.max_lvl_attack.optionalInt
		maxLvlDefense = monster.fields.max_lvl_defense.optionalInt
		speed = monster.fields.speed.optionalInt
		critRate = monster.fields.crit_rate.optionalInt
		critDamage = monster.fields.crit_damage.optionalInt
		resistance = monster.fields.resistance.optionalInt
		accuracy = monster.fields.accuracy.optionalInt
		homunculus = monster.fields.homunculus.bool
		craftCost = monster.fields.craft_cost.optionalInt
		transformsToId = monster.fields.transforms_to.optionalInt

		awakenMatsFireLow  = monster.fields.awaken_mats_fire_low.int16
		awakenMatsFireMid  = monster.fields.awaken_mats_fire_mid.int16
		awakenMatsFireHigh = monster.fields.awaken_mats_fire_high.int16

		awakenMatsWaterLow  = monster.fields.awaken_mats_water_low.int16
		awakenMatsWaterMid  = monster.fields.awaken_mats_water_mid.int16
		awakenMatsWaterHigh = monster.fields.awaken_mats_water_high.int16

		awakenMatsWindLow   = monster.fields.awaken_mats_wind_low.int16
		awakenMatsWindMid   = monster.fields.awaken_mats_wind_mid.int16
		awakenMatsWindHigh  = monster.fields.awaken_mats_wind_high.int16

		awakenMatsLightLow  = monster.fields.awaken_mats_light_low.int16
		awakenMatsLightMid  = monster.fields.awaken_mats_light_mid.int16
		awakenMatsLightHigh = monster.fields.awaken_mats_light_high.int16

		awakenMatsDarkLow   = monster.fields.awaken_mats_dark_low.int16
		awakenMatsDarkMid   = monster.fields.awaken_mats_dark_mid.int16
		awakenMatsDarkHigh  = monster.fields.awaken_mats_fire_high.int16

		awakenMatsMagicLow  = monster.fields.awaken_mats_magic_low.int16
		awakenMatsMagicMid  = monster.fields.awaken_mats_magic_mid.int16
		awakenMatsMagicHigh = monster.fields.awaken_mats_magic_high.int16

		farmable      = monster.fields.farmable.bool
		fusionFood    = monster.fields.fusion_food.bool
		bestiarySlug  = monster.fields.bestiary_slug.string

		var jsonArr:[JSON] = monster.fields.skills.array
		skills =  jsonArr.map { $0.int}

		jsonArr = monster.fields.source.array
		source =  jsonArr.map { $0.int}
	}

    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

        docInfo.taskContext.perform {
            Monster.batchUpdate(from: MonsterData.items,
                                docInfo: docInfo)
            do {
                if docInfo.taskContext.hasChanges {
                    try docInfo.taskContext.save()
                }
            } catch {
                print("could not save context")
            }
        }
    }
}
