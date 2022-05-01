//
//  GameItem.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData
import Codextended

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

@objc(GameItem)
public class GameItem: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case fields
		case com2usId = "com2us_id"
		case name
		case c2uDescription = "description"
		case imageFilename = "icon"
		case category
		case slug
		case sellValue = "sell_value"
	}

	/// Required init for Decodable conformance
	///
	public required convenience init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
//		self.id = try decoder.decode(Int64.self, forKey: .id)
//		let fields: [String: Any] = decoder.decode("fields")
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.com2usId = (fields["com2us_id"]).orInt
		self.name = (fields["name"]).orEmpty
		self.c2uDescription = (fields["description"]).orEmpty
		self.category = (fields["category"]).orInt
		self.imageFilename = (fields["icon"]).orEmpty
		self.sellValue = (fields["sell_value"]).orInt
		self.slug = (fields["slug"]).orEmpty
	}

	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}
}

extension GameItem {
	static func findById(_ gameItemId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> GameItem? {
        
        let request : NSFetchRequest<GameItem> = GameItem.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", gameItemId)
        
        if let results = try? context.fetch(request) {
        
            if let gameItem = results.first {
                return gameItem
            }
        }
        return nil
    }

	static func findOrCreate(_ id: Int64,
							 context: NSManagedObjectContext) -> GameItem {
		if let gameItem = GameItem.findById(id, context: context) {
			return gameItem
		}
		let gameItem = GameItem(context: context)
		gameItem.id = id
		return gameItem
	}

// func update<T: JsonArray>(from: T, provider: BestiaryProvider) {
//
//	 let gameItemData = from as! GameItemData
//
//	 if self.id != gameItemData.id {
//		 self.id = Int64(gameItemData.id)
//	 }
//	 self.name = gameItemData.name
//
//	 self.com2usId = Int64(gameItemData.com2usId)
//
//	 self.c2uDescription = gameItemData.c2uDescription
//
//	 self.imageFilename = gameItemData.imageFilename
//
//	 self.category = gameItemData.category
//
//	 self.slug = gameItemData.slug
//
//	 self.sellValue = gameItemData.sellValue
// }
//
// static func insertOrUpdate<T: JsonArray>(from: T,
//										  provider: BestiaryProvider) {
//	 provider.taskContext.performAndWait {
//		 let gameItemData = from as! GameItemData
//		 let gameItem = GameItem.findOrCreate(gameItemData.com2usId, context: provider.taskContext)
//		 gameItem.update(from: gameItemData, provider: provider)
//	 }
// }
//
// static func batchUpdate<T: JsonArray>(from: [T],
//									   provider: BestiaryProvider) {
//	 let gameItems = from as! [GameItemData]
//	 for gameItem in gameItems {
//		 GameItem.insertOrUpdate(from: gameItem, provider: provider)
//	 }
// }

}
