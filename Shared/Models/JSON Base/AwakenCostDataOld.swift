//
//  AwakenCostData.swift
//  Testing123
//
//  Created by Deirdre Saoirse Moen on 12/17/20.
//

import Foundation
import CoreData

public struct AwakenCostData: JsonArray {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case item
        case quantity
        case monster
    }
    
    static var items = [AwakenCostData]()
    
    let id:             Int64
    let item:           Int64
    let quantity:       Int64
    let monster:        Int64

    public init(awaken: JSON, pk: Int64) {
        id = awaken.pk.int
        item = awaken.fields.item.int
        quantity = awaken.fields.quantity.int
        monster = awaken.fields.monster.int
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            AwakenCost.batchUpdate(from: AwakenCostData.items,
                                   docInfo: docInfo)
            do {
                if docInfo.taskContext.hasChanges {
                    try docInfo.taskContext.save()
                }
                else
                {
                    print("No context changes for awaken cost data.")
                }
            } catch {
                print("could not save context")
            }
        }
    }

}

/*
 {
   "model": "bestiary.awakencost",
   "pk": 1,
   "fields": {
     "item": 13,
     "quantity": 5,
     "monster": 311
   }
 },
*/
