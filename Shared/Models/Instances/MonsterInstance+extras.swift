//
//  Monster.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// EHP = HP*(1140+(DEF*3.5))/1000

// MARK: - Core Data

@objc(MonsterInstance)
public class MonsterInstance: NSManagedObject, Comparable, Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "unit_id"
        case summonerId = "wizard_id"
        case monsterId = "unit_master_id"
        case level = "unit_level"
        case stars = "class"
        case con
        case atk
        case def
        case spd
        case resist
        case accuracy
        case critRate = "critical_rate"
        case critDamage = "critical_damage"
        case skills
        case runes
        case artifacts
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for MonsterInstance]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "MonsterInstance", in: context) else { fatalError("Could not get entity [for MonsterInstance]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.summoner = Summoner.findById(self.summonerId, context: context)
        self.monsterId = try container.decode(Int64.self, forKey: .monsterId)
        self.monster = Monster.findById(id: self.monsterId, context: context)
        self.level = try container.decode(Int16.self, forKey: .level)
        self.stars = try container.decode(Int16.self, forKey: .stars)
        self.con = try container.decode(Int32.self, forKey: .con)
        self.atk = try container.decode(Int16.self, forKey: .atk)
        self.def = try container.decode(Int16.self, forKey: .def)
        self.spd = try container.decode(Int16.self, forKey: .spd)
        self.resist = try container.decode(Int16.self, forKey: .resist)
        self.accuracy = try container.decode(Int16.self, forKey: .accuracy)
        self.critRate = try container.decode(Int16.self, forKey: .critRate)
        self.critDamage = try container.decode(Int16.self, forKey: .critDamage)
    }

    func monsterRunesSorted() -> [RuneInstance] {
        let sortNameDescriptor = NSSortDescriptor.init(key: "slot", ascending: true)
        
        return (self.runes)?.sortedArray(using: [sortNameDescriptor]) as! [RuneInstance]
    }
    
    func setMonsterId(_ monster: Monster?) {
        if let m = monster {
            if self.monsterId != monster?.id {
                self.monsterId = m.id
            }
            self.monster = m
        }
    }
    
    public var ehp: Int64 {
        // EHP = HP*(1140+(DEF*3.5))/1000
        guard let m = self.monster
        else {
            return 0
        }
        
        return Int64((Float(m.maxLvlHp) * (1140 + (Float(m.maxLvlDefense) * 3.5))/1000))
    }
    
    public var skillUpsNeeded: Int16 {
        var result: Int16 = 0

        guard let m = self.monster
        else {
            return result
        }
        
        let skillUpsToMax = m.skillUpsToMax
       
        result = Int16(skillUpsToMax) - self.skill1Level - self.skill2Level - self.skill3Level - self.skill4Level
        
        return result
    }

    // MARK: - Wrapped values for views

    var runedHp: Int {
        var runed: Int32 = runeHp + artifactHP
        if let monster = self.monster {
            runed += Int32(monster.maxLvlHp)
        }
        return Int(runed)
    }

    var runedAttack: Int {
        var runed: Int16 = runeAttack + artifactAttack
        if let monster = self.monster {
            runed += Int16(monster.maxLvlAttack)
        }
        return Int(runed)
    }

    var runedDefense: Int {
        var runed: Int16 = runeDefense + artifactDefense
        if let monster = self.monster {
            runed += Int16(monster.maxLvlDefense)
        }
        return Int(runed)
    }

    var runedSpeed: Int {
        var runed: Int16 = runeSpeed
        if let monster = self.monster {
            runed += Int16(monster.speed)
        }
        return Int(runed)
    }

    var runedCritRate: Int {
        var runed: Int16 = runeCritRate
        if let monster = self.monster {
            runed += Int16(monster.critRate)
        }
        return Int(runed)
    }

    var runedCritDamage: Int {
        var runed: Int16 = runeCritDamage
        if let monster = self.monster {
            runed += Int16(monster.critDamage)
        }
        return Int(runed)
    }

    var runedResistance: Int {
        var runed: Int16 = runeResistance
        if let monster = self.monster {
            runed += Int16(monster.resistance)
        }
        return Int(runed)
    }

    var runedAccuracy: Int {
        var runed: Int16 = runeAccuracy
        if let monster = self.monster {
            runed += Int16(monster.accuracy)
        }
        return Int(runed)
    }


    // MARK: - JSON Import Functions

    static func findById(_ monsterInstanceId: Int64,
                                 context: NSManagedObjectContext)
    -> MonsterInstance? {
        
        let request : NSFetchRequest<MonsterInstance> = MonsterInstance.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", monsterInstanceId)
        
        if let results = try? context.fetch(request) {
        
            if let monster = results.first {
                return monster
            }
        }
        return nil
    }

    public static func < (lhs: MonsterInstance, rhs: MonsterInstance) -> Bool {
        lhs.id < rhs.id
    }
}

// MARK: - JSON

/**
 A struct encapsulating the properties of a Rune. All members are
 optional in case they are missing from the data. Note: this is for the
 SWEX export data format.
 */


// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.herders_monsterinstance
    (
         id uuid NOT NULL,
         com2us_id bigint,
         created timestamp with time zone,
         stars integer NOT NULL,
         level integer NOT NULL,
         skill_1_level integer NOT NULL,
         skill_2_level integer NOT NULL,
         skill_3_level integer NOT NULL,
         skill_4_level integer NOT NULL,
         fodder boolean NOT NULL,
         in_storage boolean NOT NULL,
         ignore_for_fusion boolean NOT NULL,
         priority integer,
         notes text COLLATE pg_catalog."default",
         custom_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
         rune_hp integer NOT NULL,
         rune_attack integer NOT NULL,
         rune_defense integer NOT NULL,
         rune_speed integer NOT NULL,
         rune_crit_rate integer NOT NULL,
         rune_crit_damage integer NOT NULL,
         rune_resistance integer NOT NULL,
         rune_accuracy integer NOT NULL,
         avg_rune_efficiency double precision,
         monster_id integer NOT NULL,
         owner_id integer NOT NULL,
         default_build_id uuid,
         rta_build_id uuid,
         artifact_attack integer NOT NULL,
         artifact_defense integer NOT NULL,
         artifact_hp integer NOT NULL,
         CONSTRAINT herders_monsterinstance_pkey PRIMARY KEY (id),
         CONSTRAINT herders_monsterinsta_default_build_id_262e91d7_fk_herders_r FOREIGN KEY (default_build_id)
             REFERENCES public.herders_runebuild (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_monster_id_6d31fc16_fk_bestiary_ FOREIGN KEY (monster_id)
             REFERENCES public.bestiary_monster (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_owner_id_b6eba280_fk_herders_s FOREIGN KEY (owner_id)
             REFERENCES public.herders_summoner (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_rta_build_id_357a7725_fk_herders_r FOREIGN KEY (rta_build_id)
             REFERENCES public.herders_runebuild (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED
    )

*/

/*
 let unitId:             Int64
 let com2usId:           Int64
 let summonerId:         Int64   // points to Summoner object
 let monsterId:          Int64   // points to Monster object
 let unitLevel:          Int64
 let monsterClass:       Int64
 let con:                Int64
 let atk:                Int64
 let def:                Int64
 let spd:                Int64
 let resist:             Int64
 let accuracy:           Int64
 let critRate:           Int64
 let critDamage:         Int64
 var skills:             [MonsterInstanceSkillData]
 var runes:              [RuneInstanceData]
 var artifacts:          [ArtifactInstanceData]

 */
