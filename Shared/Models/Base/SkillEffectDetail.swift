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
    
    static func findById(_ skillEffectDetailId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> SkillEffectDetail? {
        
        let request : NSFetchRequest<SkillEffectDetail> = SkillEffectDetail.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillEffectDetailId)
        
        if let results = try? context.fetch(request) {
        
            if let skillEffectDetail = results.first {
                return skillEffectDetail
            }
        }
        return nil
    }

    func update<T: JsonArray>(from: T,
                              docInfo: SummonerDocumentInfo) {
        let skillEffectDetail = from as! SkillEffectDetailData
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
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let skillEffectDetailData = from as! SkillEffectDetailData
        let skillEffectDetail = SkillEffectDetail.findById(skillEffectDetailData.id, context: docInfo.taskContext) ??
            SkillEffectDetail(context: docInfo.taskContext)
        
        skillEffectDetail.update(from: skillEffectDetailData, docInfo: docInfo)
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let skillEffectDetailData = from as! [SkillEffectDetailData]
        for skillEffectDetail in skillEffectDetailData {
            SkillEffectDetail.insertOrUpdate(from: skillEffectDetail, docInfo: docInfo)
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
