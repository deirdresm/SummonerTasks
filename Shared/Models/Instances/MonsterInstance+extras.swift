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
public class MonsterInstance: NSManagedObject, Comparable, CoreDataUtility {
    
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

    func update<T: JsonArray>(from: T,
                              docInfo: SummonerDocumentInfo) {
        let monsterData = from as! MonsterInstanceData

        // don't dirty the record if you don't have to

        if self.id != monsterData.id {
            self.id = monsterData.id
        }
        if self.ownerId != monsterData.summonerId {
            self.ownerId = monsterData.summonerId
        }

        if let summoner = docInfo.summoner {
            self.summoner = summoner
        }
        if let summoner = docInfo.summoner {
            if self.summoner != summoner {
                self.summoner = summoner
            }
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

        // get the monster and save the relation

        if self.monsterId != monsterData.monsterId {
            self.monsterId = monsterData.monsterId
            
            self.monster = Monster.findById(id: monsterId,
                                            context: docInfo.taskContext)
        }

        // take care of previously unset monsters and any initially created
        // from a newer not-yet-loaded API
        if self.monster == nil {
            print("setting monster for \(self.monsterId)")
            self.monster = Monster.findById(id: self.monsterId,
                                           context: docInfo.taskContext)
            let name = self.monster?.name ?? "no name"
            print("… \(name)")
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let monsterData = from as! MonsterInstanceData
        
        docInfo.taskContext.performAndWait {
            var monsterInstance = MonsterInstance.findById(monsterData.id, context: docInfo.taskContext) ?? MonsterInstance(context: docInfo.taskContext)
            monsterInstance.update(from: monsterData, docInfo: docInfo)
        }
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let monsterInstances = from as! [MonsterInstanceData]
        for monsterInstance in monsterInstances {
//            print(monsterInstance)
            MonsterInstance.insertOrUpdate(from: monsterInstance, docInfo: docInfo)
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
