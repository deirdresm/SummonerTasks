//
//  Fusion.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data Fusion

extension Fusion: CoreDataUtility {
    
    static func findById(_ fusionId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> Fusion? {
        
        let request : NSFetchRequest<Fusion> = Fusion.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", fusionId)
        
        if let results = try? context.fetch(request) {
        
            if let fusion = results.first {
                return fusion
            }
        }
        return nil
    }
    
    func update<T: JsonArray>(from: T,
                docInfo: SummonerDocumentInfo) {
        let fusionData = from as! FusionData
        
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
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let fusionData = from as! FusionData
        let fusion: Fusion = Fusion.findById(fusionData.id, context: docInfo.taskContext) ??
            Fusion(context: docInfo.taskContext)
        
        fusion.update(from: fusionData, docInfo: docInfo)
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let fusions = from as! [FusionData]
        for fusion in fusions {
            Fusion.insertOrUpdate(from: fusion, docInfo: docInfo)
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
