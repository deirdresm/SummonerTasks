//
//  SkillScalingStat.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data ScalingStat

extension ScalingStat {
    
    convenience init(scalingStatData: ScalingStatData) {
        self.init()
        update(scalingStatData)
    }
    
    func update(_ scalingStatData: ScalingStatData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != scalingStatData.id {
            self.id = Int64(scalingStatData.id)
        }
        if self.c2uDesc != scalingStatData.c2uDesc {
            self.c2uDesc = scalingStatData.c2uDesc
        }
        if self.scalingDesc != scalingStatData.scalingDesc {
            self.scalingDesc = scalingStatData.scalingDesc
        }
        if self.stat != scalingStatData.stat {
            self.stat = scalingStatData.stat
        }
    }
    
    static func insertOrUpdate(scalingStatData: ScalingStatData,
                               context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        var scalingStat: ScalingStat!
        
        context.performAndWait {
            let request : NSFetchRequest<ScalingStat> = ScalingStat.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", scalingStatData.id)

            request.predicate = predicate
            
            let results = try? context.fetch(request)

            if results?.count == 0 {
                // insert new
                scalingStat = ScalingStat(context: context)
                scalingStat.update(scalingStatData)
             } else {
                // update existing
                scalingStat = results?.first
                scalingStat.update(scalingStatData)
             }
        }
    }
    
    static func batchUpdate(from scalingStats: [ScalingStatData],
                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        for scalingStat in scalingStats {
            ScalingStat.insertOrUpdate(scalingStatData: scalingStat, context: context)
        }
    }
}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
 CREATE TABLE public.bestiary_skill_scaling_stats
 (
     id integer NOT NULL DEFAULT nextval('bestiary_skill_scaling_stats_id_seq'::regclass),
     skill_id integer NOT NULL,
     scalingstat_id integer NOT NULL,
     CONSTRAINT bestiary_skill_scaling_stats_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_skill_scaling_s_skill_id_scalingstat_id_26c92422_uniq UNIQUE (skill_id, scalingstat_id),
     CONSTRAINT bestiary_skill_scali_scalingstat_id_8218a512_fk_bestiary_ FOREIGN KEY (scalingstat_id)
         REFERENCES public.bestiary_scalingstat (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_skill_scali_skill_id_0cc73ebc_fk_bestiary_ FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )


 */
