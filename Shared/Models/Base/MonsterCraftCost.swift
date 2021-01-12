//
//  MonsterCraftCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import CoreData

extension MonsterCraftCost: CoreDataUtility {
    static func findById(_ monsterCraftCostId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> MonsterCraftCost? {
        
        let request : NSFetchRequest<MonsterCraftCost> = MonsterCraftCost.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", monsterCraftCostId)
        
        if let results = try? context.fetch(request) {
        
            if let monsterCraftCost = results.first {
                return monsterCraftCost
            }
        }
        return nil
    }
    
    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let monsterCraftCostData = from as! MonsterCraftCostData
        
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
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        docInfo.taskContext.performAndWait {
            let monsterCraftCostData = from as! MonsterCraftCostData
            let monsterCraftCost = MonsterCraftCost.findById(monsterCraftCostData.id, context: docInfo.taskContext) ?? MonsterCraftCost(context: docInfo.taskContext)
            monsterCraftCost.update(from: monsterCraftCostData, docInfo: docInfo)
        }
        
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let monsterCraftCosts = from as! [MonsterCraftCostData]
        for monsterCraftCost in monsterCraftCosts {
            MonsterCraftCost.insertOrUpdate(from: monsterCraftCost, docInfo: docInfo)
        }
    }

}

