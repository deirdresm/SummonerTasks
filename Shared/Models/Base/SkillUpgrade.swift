//
//  SkillUpgrade.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data

extension SkillUpgrade: Comparable, CoreDataUtility {
    
    static func findById(_ skillDataId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> SkillUpgrade? {
        
        let request : NSFetchRequest<SkillUpgrade> = SkillUpgrade.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillDataId)
        
        if let results = try? context.fetch(request) {
        
            if let skill = results.first {
                return skill
            }
        }
        return nil
    }

    func update<T: JsonArray>(from: T,
                              docInfo: SummonerDocumentInfo) {
        let skillUpgrade = from as! SkillUpgradeData
        
        // don't dirty the record if you don't have to
        
        if self.id != skillUpgrade.id {
            self.id = Int64(skillUpgrade.id)
        }
        if self.level != skillUpgrade.level {
            self.level = skillUpgrade.level
        }
        if self.effectId != skillUpgrade.effect {
            self.effectId = skillUpgrade.effect
        }
        if self.amount != skillUpgrade.amount {
            self.amount = skillUpgrade.amount
        }
        if self.skillId != skillUpgrade.skill {
            self.skillId = skillUpgrade.skill
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let skillUpgrade = from as! SkillUpgradeData
        let skill = SkillUpgrade.findById(skillUpgrade.id, context: docInfo.taskContext) ??
            SkillUpgrade(context: docInfo.taskContext)
        
        skill.update(from: skillUpgrade, docInfo: docInfo)
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let skillUpgrades = from as! [SkillUpgradeData]
        for skillUpgrade in skillUpgrades {
            SkillUpgrade.insertOrUpdate(from: skillUpgrade, docInfo: docInfo)
        }
    }

    // MARK: - Comparable conformance
    
    public static func < (lhs: SkillUpgrade, rhs: SkillUpgrade) -> Bool {
        lhs.level < rhs.level
    }
}


// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
     CREATE TABLE public.bestiary_skillupgrade
     (
         id integer NOT NULL DEFAULT nextval('bestiary_skillupgrade_id_seq'::regclass),
         level integer NOT NULL,
         effect integer NOT NULL,
         amount integer NOT NULL,
         skill_id integer NOT NULL,
         CONSTRAINT bestiary_skillupgrade_pkey PRIMARY KEY (id),
         CONSTRAINT bestiary_skillupgrade_skill_id_1b1822ee_fk_bestiary_skill_id FOREIGN KEY (skill_id)
             REFERENCES public.bestiary_skill (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED
     )
 */
