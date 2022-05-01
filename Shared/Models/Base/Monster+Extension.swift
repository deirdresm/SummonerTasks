//
//  BestiaryMonster.swift
//  SummonerTasks (iOS)
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData
import Codextended
import SwiftUI

// MARK: - Core Data

/**
 Managed object subclass extension for the Quake entity.
 */
@objc(Monster)
public class Monster: NSManagedObject, Decodable {

//	public var type: String?
//	public var descrip: String?

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case name
		case com2usId
		case skillGroupId
		case familyId
		case imageFilename
		case element
		case archetype
		case baseStars
		case naturalStars
		case obtainable

		// awakening stuff
		case canAwaken
		case isAwakened
		case awakenLevel
		case awakenBonus
		case awakensToId = "awakens_to"
		case awakensFromId = "awakens_from"

		case skillUpsToMax
		case leaderSkillId = "leader_skill"
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

		case awakenMatsFireLow, awakenMatsFireMid, awakenMatsFireHigh
		case awakenMatsWaterLow, awakenMatsWaterMid, awakenMatsWaterHigh
		case awakenMatsWindLow, awakenMatsWindMid, awakenMatsWindHigh
		case awakenMatsLightLow, awakenMatsLightMid, awakenMatsLightHigh
		case awakenMatsDarkLow, awakenMatsDarkMid, awakenMatsDarkHigh
		case awakenMatsMagicLow, awakenMatsMagicMid, awakenMatsMagicHigh

		case farmable
		case fusionFood
		case bestiarySlug

		case skills
		case source

		case fields
	}

	/// Required init for Decodable conformance
	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "Monster", in: context) else { fatalError("Could not get entity [for Monster]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		// and start decoding
		self.id = (fields["id"]).orInt
		self.name = (fields["name"]).orEmpty
		self.com2usId = (fields["com2us_id"]).orInt
		self.familyId = (fields["family_id"]).orInt
		self.skillGroupId = (fields["skill_group_id"]).orInt
		self.imageFilename = (fields["image_filename"]).orEmpty
		self.element = (fields["element"]).orEmpty
		self.archetype = (fields["archetype"]).orEmpty
		self.baseStars =  (fields["base_stars"]).orInt16
		self.naturalStars = (fields["natural_stars"]).orInt16
		self.obtainable = (fields["obtainable"]).orFalse

		// awakening
		self.canAwaken = (fields["can_awaken"]).orFalse
		self.isAwakened = (fields["is_awakened"]).orFalse
		self.awakenLevel = (fields["awaken_level"]).orInt16
		self.awakenBonus = (fields["awaken_bonus"]).orEmpty
		self.awakensToId = (fields["awakens_to"]).orOptionalInt
		self.awakensFromId = (fields["awakens_from"]).orOptionalInt

		self.skillUpsToMax = (fields["skill_ups_to_max"]).orInt
		self.leaderSkillId = (fields["leader_skill"]).orOptionalInt
		self.rawHp = (fields["raw_hp"]).orInt
		self.rawAttack = (fields["raw_attack"]).orInt
		self.rawDefense = (fields["raw_defense"]).orInt
		self.baseHp = (fields["base_hp"]).orInt
		self.baseAttack = (fields["base_attack"]).orInt
		self.baseDefense = (fields["base_defense"]).orInt
		self.maxLvlHp = (fields["max_lvl_hp"]).orInt
		self.maxLvlAttack = (fields["max_lvl_attack"]).orInt
		self.maxLvlDefense = (fields["max_lvl_defense"]).orInt
		self.speed = (fields["speed"]).orInt
		self.critRate = (fields["crit_rate"]).orInt
		self.critDamage = (fields["crit_damage"]).orInt
		self.resistance = (fields["resistance"]).orInt
		self.accuracy = (fields["accuracy"]).orInt
		self.isHomunculus = (fields["homunculus"]).orFalse
		self.craftCost = (fields["craft_cost"]).orInt
		self.transformsToId = (fields["transforms_to"]).orOptionalInt

		// materials
		self.awakenMatsFireLow = (fields["awaken_mats_fire_low"]).orInt16
		self.awakenMatsFireMid = (fields["awaken_mats_fire_mid"]).orInt16
		self.awakenMatsFireHigh = (fields["awaken_mats_fire_high"]).orInt16
		self.awakenMatsWaterLow = (fields["awaken_mats_water_low"]).orInt16
		self.awakenMatsWaterMid = (fields["awaken_mats_water_mid"]).orInt16
		self.awakenMatsWaterHigh = (fields["awaken_mats_water_high"]).orInt16
		self.awakenMatsWindLow = (fields["awaken_mats_wind_low"]).orInt16
		self.awakenMatsWindMid = (fields["awaken_mats_wind_mid"]).orInt16
		self.awakenMatsWindHigh = (fields["awaken_mats_wind_high"]).orInt16
		self.awakenMatsLightLow = (fields["awaken_mats_light_low"]).orInt16
		self.awakenMatsLightMid = (fields["awaken_mats_light_mid"]).orInt16
		self.awakenMatsLightHigh = (fields["awaken_mats_light_high"]).orInt16
		self.awakenMatsDarkLow = (fields["awaken_mats_dark_low"]).orInt16
		self.awakenMatsDarkMid = (fields["awaken_mats_dark_mid"]).orInt16
		self.awakenMatsDarkHigh = (fields["awaken_mats_dark_high"]).orInt16
		self.awakenMatsMagicLow = (fields["awaken_mats_magic_low"]).orInt16
		self.awakenMatsMagicMid = (fields["awaken_mats_magic_mid"]).orInt16
		self.awakenMatsMagicHigh = (fields["awaken_mats_magic_high"]).orInt16
		self.isFarmable = (fields["farmable"]).orFalse
		self.isFusionFood = (fields["fusion_food"]).orFalse
		self.bestiarySlug = (fields["bestiary_slug"]).orEmpty

		let skills = fields["skills"].orIntArray
		for skillNum in skills {
			if let skill = Skill.findById(skillNum) {
				self.addObject(value: skill, forKey: "skills")
			}
		}

		if let ls = self.leaderSkillId {
			if let skill = LeaderSkill.findById(Int64(ls)) {
				self.leaderSkill = skill
			}
		}

		let sources = fields["sources"].orIntArray
		for sourceId in sources {
			if let source = Source.findById(sourceId, context: context) {
				self.addObject(value: source, forKey: "source")
			}
		}
	}

	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

    static func findById(_ id: Int64,
                    context: NSManagedObjectContext) -> Monster? {

        let request: NSFetchRequest<Monster> = Monster.fetchRequest()

        request.predicate = NSPredicate(format: "id == %i", id)

        let results = try? context.fetch(request)

        if let _ = results?.count {
            return(results?.first)
        } else {
            return(nil)
        }
    }

	var nameWrapped: String {
		name ?? ""
	}

    static func portrait(monster: Monster) -> Image {
        return Image(
            ImageStore.loadImage(type: ImageType.monsters, name: monster.imageFilename!),
            scale: 1,
            label: Text(monster.name!))
    }
    
    public var sourceArray: [Source] {
        let set = source as? Set<Source> ?? []
        return set.sorted {
            $0.metaOrder < $1.metaOrder
        }
    }
    public var skillsSorted: [Skill] {
        let set = skills as? Set<Skill> ?? []
        return set.sorted {
            $0.slot < $1.slot
        }
    }
    
    public var ehp: Int64 {
        // EHP = HP*(1140+(DEF*3.5))/1000
        return Int64((Float(self.maxLvlHp) * (1140 + (Float(self.maxLvlDefense) * 3.5))/1000))
    }

	static func findOrCreate(_ id: Int64,
							 context: NSManagedObjectContext) -> Monster {
		if let monster = Monster.findById(id, context: context) {
			return monster
		}
		let monster = Monster(context: context)
		monster.id = id
		return monster
	}
}

//public struct MonsterCatalog: View {
//    /// Creates a new view that displays shared UI components for given `Monster` instance.
//    ///
//    /// - Parameters:
//    ///   - name: A name of `Playbook` to be displayed on the user interface.
//    ///   - playbook: A `Playbook` instance that manages scenarios to be displayed.
//    public init(
//        name: String = "PLAYBOOK",
//        playbook: Playbook = .default
//    ) {
//        underlyingView = PlaybookCatalogInternal(
//            name: name,
//            playbook: playbook,
//            store: CatalogStore(playbook: playbook)
//        )
//    }
//
//    /// Declares the content and behavior of this view.
//    public var body: some View {
//        underlyingView
//    }
//
//}

// TODO: set up relations and indices
