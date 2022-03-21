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
	}

	/// Required init for Decodable conformance
	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// and start decoding
		self.id = try decoder.decode("id")
		self.name = try decoder.decode("name")
		self.com2usId = try decoder.decode("com2usId")
		self.familyId = try decoder.decode("familyId")
		self.skillGroupId = try decoder.decode("skillGroupId")
		self.imageFilename = try decoder.decode("imageFilename")
		self.element = try decoder.decode("element")
		self.archetype = try decoder.decode("archetype")
		self.baseStars = try decoder.decode("baseStars")
		self.naturalStars = try decoder.decode("naturalStars")
		self.obtainable = try decoder.decode("obtainable")

		// awakening
		self.canAwaken = try decoder.decode("canAwaken")
		self.isAwakened = try decoder.decode("isAwakened")
		self.awakenLevel = try decoder.decode("awakenLevel")
		self.awakenBonus = try decoder.decode("awakenBonus")
		self.awakensToId = try decoder.decode("awakensToId")
		self.awakensFromId = try decoder.decode("awakensFromId")

		self.skillUpsToMax = try decoder.decode("skillUpsToMax")
		self.leaderSkillId = try decoder.decode("leaderSkillId")
		self.rawHp = try decoder.decode("rawHp")
		self.rawAttack = try decoder.decode("rawAttack")
		self.rawDefense = try decoder.decode("rawDefense")
		self.baseHp = try decoder.decode("baseHp")
		self.baseAttack = try decoder.decode("baseAttack")
		self.baseDefense = try decoder.decode("baseDefense")
		self.maxLvlHp = try decoder.decode("maxLvlHp")
		self.maxLvlAttack = try decoder.decode("maxLvlAttack")
		self.maxLvlDefense = try decoder.decode("maxLvlDefense")
		self.speed = try decoder.decode("speed")
		self.critRate = try decoder.decode("critRate")
		self.critDamage = try decoder.decode("critDamage")
		self.resistance = try decoder.decode("resistance")
		self.accuracy = try decoder.decode("accuracy")
		self.isHomunculus = try decoder.decode("homunculus")
		self.craftCost = try decoder.decode("craftCost")
		self.transformsToId = try decoder.decode("transformsToId")

		// materials
		self.awakenMatsFireLow = try decoder.decode("awakenMatsFireLow")
		self.awakenMatsFireMid = try decoder.decode("awakenMatsFireMid")
		self.awakenMatsFireHigh = try decoder.decode("awakenMatsFireHigh")
		self.awakenMatsWaterLow = try decoder.decode("awakenMatsWaterLow")
		self.awakenMatsWaterMid = try decoder.decode("awakenMatsWaterMid")
		self.awakenMatsWaterHigh = try decoder.decode("awakenMatsWaterHigh")
		self.awakenMatsWindLow = try decoder.decode("awakenMatsWindLow")
		self.awakenMatsWindMid = try decoder.decode("awakenMatsWindMid")
		self.awakenMatsWindHigh = try decoder.decode("awakenMatsWindHigh")
		self.awakenMatsLightLow = try decoder.decode("awakenMatsLightLow")
		self.awakenMatsLightMid = try decoder.decode("awakenMatsLightMid")
		self.awakenMatsLightHigh = try decoder.decode("awakenMatsLightHigh")
		self.awakenMatsDarkLow = try decoder.decode("awakenMatsDarkLow")
		self.awakenMatsDarkMid = try decoder.decode("awakenMatsDarkMid")
		self.awakenMatsDarkHigh = try decoder.decode("awakenMatsDarkHigh")
		self.awakenMatsMagicLow = try decoder.decode("awakenMatsMagicLow")
		self.awakenMatsMagicMid = try decoder.decode("awakenMatsMagicMid")
		self.awakenMatsMagicHigh = try decoder.decode("awakenMatsMagicHigh")
		self.isFarmable = try decoder.decode("farmable")
		self.isFusionFood = try decoder.decode("fusionFood")
		self.bestiarySlug = try decoder.decode("bestiarySlug")
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

/**
 A struct encapsulating the properties of a Quake. All members are
 optional in case they are missing from the data.
 */

// TODO: set up relations and indices

// MARK: - Original SQL Table Definition

/*
 -- Table: public.bestiary_monster

 -- DROP TABLE public.bestiary_monster;

 CREATE TABLE public.bestiary_monster
 (
     id integer NOT NULL DEFAULT nextval('bestiary_monster_id_seq'::regclass),
     name character varying(40) COLLATE pg_catalog."default" NOT NULL,
     com2us_id integer,
     family_id integer,
     image_filename character varying(250) COLLATE pg_catalog."default",
     element character varying(6) COLLATE pg_catalog."default" NOT NULL,
     archetype character varying(10) COLLATE pg_catalog."default" NOT NULL,
     base_stars integer NOT NULL,
     obtainable boolean NOT NULL,
     can_awaken boolean NOT NULL,
     is_awakened boolean NOT NULL,
     awaken_bonus text COLLATE pg_catalog."default" NOT NULL,
     skill_ups_to_max integer,
     raw_hp integer,
     raw_attack integer,
     raw_defense integer,
     base_hp integer,
     base_attack integer,
     base_defense integer,
     max_lvl_hp integer,
     max_lvl_attack integer,
     max_lvl_defense integer,
     speed integer,
     crit_rate integer,
     crit_damage integer,
     resistance integer,
     accuracy integer,
     homunculus boolean NOT NULL,
     craft_cost integer,
     awaken_mats_fire_low integer NOT NULL,
     awaken_mats_fire_mid integer NOT NULL,
     awaken_mats_fire_high integer NOT NULL,
     awaken_mats_water_low integer NOT NULL,
     awaken_mats_water_mid integer NOT NULL,
     awaken_mats_water_high integer NOT NULL,
     awaken_mats_wind_low integer NOT NULL,
     awaken_mats_wind_mid integer NOT NULL,
     awaken_mats_wind_high integer NOT NULL,
     awaken_mats_light_low integer NOT NULL,
     awaken_mats_light_mid integer NOT NULL,
     awaken_mats_light_high integer NOT NULL,
     awaken_mats_dark_low integer NOT NULL,
     awaken_mats_dark_mid integer NOT NULL,
     awaken_mats_dark_high integer NOT NULL,
     awaken_mats_magic_low integer NOT NULL,
     awaken_mats_magic_mid integer NOT NULL,
     awaken_mats_magic_high integer NOT NULL,
     farmable boolean NOT NULL,
     fusion_food boolean NOT NULL,
     bestiary_slug character varying(255) COLLATE pg_catalog."default",
     awakens_from_id integer,
     awakens_to_id integer,
     leader_skill_id integer,
     awaken_level integer NOT NULL,
     natural_stars integer NOT NULL,
     transforms_to_id integer,
     CONSTRAINT bestiary_monster_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_monster_awakens_from_id_38a30ba6_fk_bestiary_ FOREIGN KEY (awakens_from_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_monster_awakens_to_id_daac8302_fk_bestiary_monster_id FOREIGN KEY (awakens_to_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_monster_leader_skill_id_7fc43dfc_fk_bestiary_ FOREIGN KEY (leader_skill_id)
         REFERENCES public.bestiary_leaderskill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_monster_transforms_to_id_ecb4e99c_fk_bestiary_ FOREIGN KEY (transforms_to_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )
 WITH (
     OIDS = FALSE
 )
 TABLESPACE pg_default;

 ALTER TABLE public.bestiary_monster
     OWNER to swarfarmer_dev;

 -- Index: bestiary_monster_awakens_from_id_38a30ba6

 -- DROP INDEX public.bestiary_monster_awakens_from_id_38a30ba6;

 CREATE INDEX bestiary_monster_awakens_from_id_38a30ba6
     ON public.bestiary_monster USING btree
     (awakens_from_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: bestiary_monster_awakens_to_id_daac8302

 -- DROP INDEX public.bestiary_monster_awakens_to_id_daac8302;

 CREATE INDEX bestiary_monster_awakens_to_id_daac8302
     ON public.bestiary_monster USING btree
     (awakens_to_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: bestiary_monster_bestiary_slug_67ff9e5f

 -- DROP INDEX public.bestiary_monster_bestiary_slug_67ff9e5f;

 CREATE INDEX bestiary_monster_bestiary_slug_67ff9e5f
     ON public.bestiary_monster USING btree
     (bestiary_slug COLLATE pg_catalog."default" ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: bestiary_monster_bestiary_slug_67ff9e5f_like

 -- DROP INDEX public.bestiary_monster_bestiary_slug_67ff9e5f_like;

 CREATE INDEX bestiary_monster_bestiary_slug_67ff9e5f_like
     ON public.bestiary_monster USING btree
     (bestiary_slug COLLATE pg_catalog."default" varchar_pattern_ops ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: bestiary_monster_leader_skill_id_7fc43dfc

 -- DROP INDEX public.bestiary_monster_leader_skill_id_7fc43dfc;

 CREATE INDEX bestiary_monster_leader_skill_id_7fc43dfc
     ON public.bestiary_monster USING btree
     (leader_skill_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: bestiary_monster_transforms_to_id_ecb4e99c

 -- DROP INDEX public.bestiary_monster_transforms_to_id_ecb4e99c;

 CREATE INDEX bestiary_monster_transforms_to_id_ecb4e99c
     ON public.bestiary_monster USING btree
     (transforms_to_id ASC NULLS LAST)
     TABLESPACE pg_default;
 
*/
