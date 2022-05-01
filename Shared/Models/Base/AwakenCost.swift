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
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "AwakenCost", in: context) else { fatalError("Could not get entity [for AwakenCost]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.itemId = (fields["item"]).orInt
		if let gitem = GameItem.findById(self.itemId, context: context) {
			self.item = gitem
		}

		self.quantity = (fields["quantity"]).orInt

		self.monsterId = (fields["monster"]).orInt
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
}

