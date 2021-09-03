//
//  AwakenCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData

@objc(AwakenCost)
public class AwakenCost: NSManagedObject, Comparable, Decodable {
    public static func < (lhs: AwakenCost, rhs: AwakenCost) -> Bool {
        lhs.id < rhs.id
    }

    static func findById(_ awakenCostId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> AwakenCost? {
        
        let request : NSFetchRequest<AwakenCost> = AwakenCost.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", awakenCostId)
        
        if let results = try? context.fetch(request) {
        
            if let awakenCost = results.first {
                return awakenCost
            }
        }
        return nil
    }

    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let awakenCostData = from as! AwakenCostData
        
        // don't dirty the record if you don't have to
        
        if self.id != awakenCostData.id {
            self.id = Int64(awakenCostData.id)
        }
        if self.item != awakenCostData.item {
            self.item = awakenCostData.item
        }
        if self.monster != awakenCostData.monster {
            self.monster = awakenCostData.monster
        }
        if self.quantity != awakenCostData.quantity {
            self.quantity = awakenCostData.quantity
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let awakenCostData = from as! AwakenCostData
        let awakenCost = AwakenCost.findById(awakenCostData.id, context: docInfo.taskContext) ??
            AwakenCost(context: docInfo.taskContext)
        
        awakenCost.update(from: awakenCostData, docInfo: docInfo)
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let awakenCosts = from as! [AwakenCostData]
        for awakenCost in awakenCosts {
            AwakenCost.insertOrUpdate(from: awakenCost, docInfo: docInfo)
        }
    }

}

