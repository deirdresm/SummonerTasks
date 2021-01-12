//
//  SkillScalingStat.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data ScalingStat

extension ScalingStat: CoreDataUtility {
    
    static func findById(_ scalingStatId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> ScalingStat? {
        
        let request : NSFetchRequest<ScalingStat> = ScalingStat.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", scalingStatId)
        
        if let results = try? context.fetch(request) {
        
            if let scalingStat = results.first {
                return scalingStat
            }
        }
        return nil
    }
    
    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let scalingStatData = from as! ScalingStatData
        
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
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        docInfo.taskContext.performAndWait {
            let scalingStatData = from as! SkillData
            let scalingStat = ScalingStat.findById(scalingStatData.com2usId, context: docInfo.taskContext) ?? ScalingStat(context: docInfo.taskContext)
            scalingStat.update(from: scalingStatData, docInfo: docInfo)
        }
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let scalingStats = from as! [ScalingStatData]
        for scalingStat in scalingStats {
            ScalingStat.insertOrUpdate(from: scalingStat, docInfo: docInfo)
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
