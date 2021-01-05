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

extension MonsterInstance: Comparable {
    
    func monsterRunesSorted() -> [RuneInstance] {
        let sortNameDescriptor = NSSortDescriptor.init(key: "slot", ascending: true)
        
        return (self.runes)?.sortedArray(using: [sortNameDescriptor]) as! [RuneInstance]
    }
    
    func setMonsterId(_ monster: Monster?) {
        if let m = monster {
            self.monsterId = m.com2usId
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
    
    public var skillUpsNeeded: Int64 {
        var result: Int64 = 0

        guard let m = self.monster
        else {
            return result
        }
        
        let skillUpsToMax = m.skillUpsToMax
       
        result = skillUpsToMax - self.skill1Level - self.skill2Level - self.skill3Level - self.skill4Level
        
        return result
    }

    // MARK: - JSON Import Functions

    func update(_ monsterData: MonsterInstanceData,
                context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        
        // don't dirty the record if you don't have to
        
        if self.id != monsterData.id {
            self.id = Int64(monsterData.id)
        }
        if self.level != monsterData.unitLevel {
            self.level = monsterData.unitLevel
        }
        if self.stars != monsterData.stars {
            self.stars = monsterData.stars
        }
        
        if monsterData.skills.count > 0 {
            if self.skill1Level != monsterData.skills[0].level {
                self.skill1Level = monsterData.skills[0].level
            }
        }
        if monsterData.skills.count > 1 {
            if self.skill2Level != monsterData.skills[1].level {
                self.skill2Level = monsterData.skills[1].level
            }
        }
        if monsterData.skills.count > 2 {
            if self.skill3Level != monsterData.skills[2].level {
                self.skill3Level = monsterData.skills[2].level
            }
        }
        if monsterData.skills.count > 3 {
            if self.skill4Level != monsterData.skills[3].level {
                self.skill4Level = monsterData.skills[3].level
            }
        }

        self.fodder = false
        
        // TODO building shit here
        
        if self.monsterId != monsterData.monsterId {
            self.monsterId = monsterData.monsterId
            
            let monster = Monster.findById(id: monsterId,
                                           context: context)
        }
    }
    
    static func insertOrUpdate(monsterData: MonsterInstanceData,
                               context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        var monsterInstance: MonsterInstance!
        
        context.performAndWait {
            let request : NSFetchRequest<MonsterInstance> = MonsterInstance.fetchRequest()

            request.predicate = NSPredicate(format: "id == %i", monsterData.id)
            
            let results = try? context.fetch(request)

            if results?.count == 0 {
                // insert new
                monsterInstance = MonsterInstance(context: context)
                monsterInstance.update(monsterData, context: context)
             } else {
                // update existing
                monsterInstance = results?.first
                monsterInstance.update(monsterData, context: context)
             }
        }
    }
    
    static func batchUpdate(from monsterInstances: [MonsterInstanceData],
                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        for monsterInstance in monsterInstances {
            MonsterInstance.insertOrUpdate(monsterData: monsterInstance, context: context)
        }
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
