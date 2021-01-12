//
//  AwakenCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData

extension AwakenCost {
    func update(_ awakenCostData: AwakenCostData) {
        
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
    
    static func insertOrUpdate(awakenCostData: AwakenCostData,
                               docInfo: SummonerDocumentInfo) {
        var awakenCost: AwakenCost!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<AwakenCost> = AwakenCost.fetchRequest()

            request.predicate = NSPredicate(format: "id == %i", awakenCostData.id)
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                awakenCost = AwakenCost(context: docInfo.taskContext)
                awakenCost.update(awakenCostData)
             } else {
                // update existing
                awakenCost = results?.first
                awakenCost.update(awakenCostData)
             }
        }
    }
    
    static func batchUpdate(from awakenCosts: [AwakenCostData],
                            docInfo: SummonerDocumentInfo) {
        for awakenCost in awakenCosts {
            AwakenCost.insertOrUpdate(awakenCostData: awakenCost, docInfo: docInfo)
        }
    }

}

