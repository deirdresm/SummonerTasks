//
//  MonsterCraftCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import CoreData

extension MonsterCraftCost: CoreDataUtility {
    func update(_ monsterCraftCostData: MonsterCraftCostData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != monsterCraftCostData.id {
            self.id = Int64(monsterCraftCostData.id)
        }
        if self.itemId != monsterCraftCostData.item {
            self.itemId = monsterCraftCostData.item
        }
        if self.monsterId != monsterCraftCostData.monster {
            self.monsterId = monsterCraftCostData.monster
        }
        if self.quantity != monsterCraftCostData.quantity {
            self.quantity = monsterCraftCostData.quantity
        }
    }
    
    static func insertOrUpdate(monsterCraftCostData: MonsterCraftCostData,
                               docInfo: SummonerDocumentInfo) {
        var monsterCraftCost: MonsterCraftCost!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<MonsterCraftCost> = MonsterCraftCost.fetchRequest()

            request.predicate = NSPredicate(format: "id == %i", monsterCraftCostData.id)
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                monsterCraftCost = MonsterCraftCost(context: docInfo.taskContext)
                monsterCraftCost.update(monsterCraftCostData)
             } else {
                // update existing
                monsterCraftCost = results?.first
                monsterCraftCost.update(monsterCraftCostData)
             }
        }
    }
    
    static func batchUpdate(from monsterCraftCosts: [MonsterCraftCostData],
                            docInfo: SummonerDocumentInfo) {
        for monsterCraftCost in monsterCraftCosts {
            MonsterCraftCost.insertOrUpdate(monsterCraftCostData: monsterCraftCost, docInfo: docInfo)
        }
    }

}

