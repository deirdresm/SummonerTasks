//
//  SkillUpgrade.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data

extension SkillUpgrade: Comparable {
    
    convenience init(skillUpgrade: SkillUpgradeData) {
        self.init()
        update(skillUpgrade)
    }
    
    func update(_ skillUpgrade: SkillUpgradeData) {
        
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
    
    static func insertOrUpdate(skillUpgrade: SkillUpgradeData,
                               docInfo: SummonerDocumentInfo) {
        var skill: SkillUpgrade!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<SkillUpgrade> = SkillUpgrade.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillUpgrade.id)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = SkillUpgrade(context: docInfo.taskContext)
                skill.update(skillUpgrade)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillUpgrade)
             }
        }
    }
    
    static func batchUpdate(from skillUpgradeData: [SkillUpgradeData],
                            docInfo: SummonerDocumentInfo) {
        for skillUpgrade in skillUpgradeData {
            SkillUpgrade.insertOrUpdate(skillUpgrade: skillUpgrade, docInfo: docInfo)
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
