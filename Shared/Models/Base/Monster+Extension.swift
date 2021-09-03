//
//  BestiaryMonster.swift
//  SummonerTasks (iOS)
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData
import SwiftUI

// MARK: - Core Data

/**
 Managed object class for the Monster entity.
 */

@objc(Monster)
public class Monster: NSManagedObject, Comparable, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case attribute
        case amount
        case area
        case element
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        id = try container.decode(Int64.self, forKey: .id)
        attribute = try container.decode(Int64.self, forKey: .attribute)
        amount = try container.decode(Int64.self, forKey: .amount)
        area = try container.decode(Int64.self, forKey: .area)
        element = try container.decode(String.self, forKey: .element)
    }

    public static func < (lhs: Monster, rhs: Monster) -> Bool {
        lhs.id < rhs.id
    }

    static func findById(id: Int64,
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

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
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
