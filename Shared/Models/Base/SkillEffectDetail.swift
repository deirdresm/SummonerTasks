//
//  SkillEffectDetail.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

extension SkillEffectDetail: CoreDataUtility {
    
    convenience init(skillEffect: SkillEffectDetailData) {
        self.init()
        update(skillEffect)
    }
    
    func update(_ skillEffectDetail: SkillEffectDetailData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != skillEffectDetail.id {
            self.id = Int64(skillEffectDetail.id)
        }
        if self.aoe != skillEffectDetail.aoe {
            self.aoe = skillEffectDetail.aoe
        }
        if self.singleTarget != skillEffectDetail.singleTarget {
            self.singleTarget = skillEffectDetail.singleTarget
        }
        if self.selfEffect != skillEffectDetail.selfEffect {
            self.selfEffect = skillEffectDetail.selfEffect
        }
        if self.aoe != skillEffectDetail.aoe {
            self.aoe = skillEffectDetail.aoe
        }

    }
    
    static func insertOrUpdate(skillEffectDetail: SkillEffectDetailData,
                               docInfo: SummonerDocumentInfo) {
        var skill: SkillEffectDetail!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<SkillEffectDetail> = SkillEffectDetail.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillEffectDetail.id)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = SkillEffectDetail(context: docInfo.taskContext)
                skill.update(skillEffectDetail)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillEffectDetail)
             }
        }
    }
    
    static func batchUpdate(from skillEffectDetailData: [SkillEffectDetailData],
                            docInfo: SummonerDocumentInfo) {
        for skillEffectDetail in skillEffectDetailData {
            SkillEffectDetail.insertOrUpdate(skillEffectDetail: skillEffectDetail, docInfo: docInfo)
        }
    }

}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_skilleffectdetail
    (
     id integer NOT NULL DEFAULT nextval('bestiary_skilleffectdetail_id_seq'::regclass),
     aoe boolean NOT NULL,
     single_target boolean NOT NULL,
     self_effect boolean NOT NULL,
     chance integer,
     on_crit boolean NOT NULL,
     on_death boolean NOT NULL,
     random boolean NOT NULL,
     quantity integer,
     "all" boolean NOT NULL,
     self_hp boolean NOT NULL,
     target_hp boolean NOT NULL,
     damage boolean NOT NULL,
     note text COLLATE pg_catalog."default",
     effect_id integer NOT NULL,
     skill_id integer NOT NULL,
     CONSTRAINT bestiary_skilleffectdetail_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_skilleffect_effect_id_fc7dd1eb_fk_bestiary_ FOREIGN KEY (effect_id)
         REFERENCES public.bestiary_skilleffect (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_skilleffect_skill_id_a8ed5058_fk_bestiary_ FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
