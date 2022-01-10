//
//  AwakenCost.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData

@objc(AwakenCost)
public class AwakenCost: NSManagedObject, Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case itemId
		case quantity
		case monsterId
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.itemId = try container.decode(Int64.self, forKey: .itemId)
		if let gitem = GameItem.findById(self.itemId, context: context) {
			self.item = gitem
		}
		self.quantity = try container.decode(Int64.self, forKey: .quantity)
		self.monsterId = try container.decode(Int64.self, forKey: .monsterId)
		if let monster = Monster.findById(self.monsterId, context: context) {
			self.monster = monster
		}
	}

	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

    static func findById(_ awakenCostId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
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

//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let awakenCostData = from as! AwakenCostData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != awakenCostData.id {
//            self.id = Int64(awakenCostData.id)
//        }
//        if self.item != awakenCostData.item {
//            self.item = awakenCostData.item
//        }
//        if self.monster != awakenCostData.monster {
//            self.monster = awakenCostData.monster
//        }
//        if self.quantity != awakenCostData.quantity {
//            self.quantity = awakenCostData.quantity
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        let awakenCostData = from as! AwakenCostData
//        let awakenCost = AwakenCost.findById(awakenCostData.id, context: docInfo.taskContext) ??
//            AwakenCost(context: docInfo.taskContext)
//        
//        awakenCost.update(from: awakenCostData, docInfo: docInfo)
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let awakenCosts = from as! [AwakenCostData]
//        for awakenCost in awakenCosts {
//            AwakenCost.insertOrUpdate(from: awakenCost, docInfo: docInfo)
//        }
//    }
//
}

