//
//  Fusion.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data Fusion

extension Fusion {
    
    convenience init(fusionData: FusionData) {
        self.init()
        update(fusionData)
    }
    
    func update(_ fusionData: FusionData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != fusionData.id {
            self.id = Int64(fusionData.id)
        }
        if self.cost != fusionData.cost {
            self.cost = Int64(fusionData.cost)
        }
        if self.metaOrder != fusionData.metaOrder {
            self.metaOrder = fusionData.metaOrder
        }
        if self.product != fusionData.product {
            self.product = fusionData.product
        }
        if self.ingredients != fusionData.ingredients {
            self.ingredients = fusionData.ingredients
        }
    }
    
    static func insertOrUpdate(fusionData: FusionData,
                               docInfo: SummonerDocumentInfo) {
        var fusion: Fusion!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<Fusion> = Fusion.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", fusionData.id)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                fusion = Fusion(context: docInfo.taskContext)
                fusion.update(fusionData)
             } else {
                // update existing
                fusion = results?.first
                fusion.update(fusionData)
             }
        }
    }
    
    static func batchUpdate(from fusions: [FusionData],
                            docInfo: SummonerDocumentInfo) {
        for fusion in fusions {
            Fusion.insertOrUpdate(fusionData: fusion, docInfo: docInfo)
        }
    }
}


// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_fusion
    (
     id integer NOT NULL DEFAULT nextval('bestiary_fusion_id_seq'::regclass),
     cost integer NOT NULL,
     meta_order integer NOT NULL,
     product_id integer NOT NULL,
     CONSTRAINT bestiary_fusion_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_fusion_product_id_47841bc7_uniq UNIQUE (product_id),
     CONSTRAINT bestiary_fusion_product_id_47841bc7_fk_bestiary_monster_id FOREIGN KEY (product_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
