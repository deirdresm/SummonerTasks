//
//  MonsterCraftCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import CoreData

@objc(MonsterCraftCost)
public class MonsterCraftCost: NSManagedObject, Comparable, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case itemId = "item"
        case monsterId = "monster"
        case quantity
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        id = try container.decode(Int64.self, forKey: .id)
        itemId = try container.decode(Int64.self, forKey: .itemId)
        monsterId = try container.decode(Int64.self, forKey: .monsterId)
        quantity = try container.decode(Int64.self, forKey: .quantity)
    }

    public static func < (lhs: MonsterCraftCost, rhs: MonsterCraftCost) -> Bool {
        lhs.id < rhs.id
    }

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
    
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let monsterCraftCostData = from as! MonsterCraftCostData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != monsterCraftCostData.id {
//            self.id = Int64(monsterCraftCostData.id)
//        }
//        if self.itemId != monsterCraftCostData.item {
//            self.itemId = monsterCraftCostData.item
//        }
//        if self.monsterId != monsterCraftCostData.monster {
//            self.monsterId = monsterCraftCostData.monster
//        }
//        if self.quantity != monsterCraftCostData.quantity {
//            self.quantity = monsterCraftCostData.quantity
//        }
//    }

}

