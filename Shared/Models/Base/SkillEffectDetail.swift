//
//  SkillEffectDetail.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

@objc(SkillEffectDetail)
public class SkillEffectDetail: NSManagedObject, Comparable, Decodable {
    public static func < (lhs: SkillEffectDetail, rhs: SkillEffectDetail) -> Bool {
        lhs.id < rhs.id
    }

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
