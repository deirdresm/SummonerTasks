//
//  MonsterCraftCostData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData

public struct MonsterCraftCostData: JsonArray, Decodable {

    static var items = [MonsterCraftCostData]()

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case item
        case quantity
        case monster
    }
    
    let id:             Int64
    let item:           Int64
    let quantity:       Int64
    let monster:        Int64

    public init(monsterCraft: JSON, pk: Int64) {
        id = pk
        item = monsterCraft.fields.item.int
        quantity = monsterCraft.fields.quantity.int
        monster = monsterCraft.fields.monster.int
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            MonsterCraftCost.batchUpdate(from: MonsterCraftCostData.items,
                                         docInfo: docInfo)
            do {
                if docInfo.taskContext.hasChanges {
                    try docInfo.taskContext.save()
                }
            } catch {
                print("could not save context")
            }
        }
    }
}

/*
 {
    "model": "bestiary.monstercraftcost",
    "pk": 429,
    "fields": {
      "item": 40,
      "quantity": 300,
      "monster": 1007
    }
  },

 */
