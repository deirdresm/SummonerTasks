//
//  GameItem.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData
import Codextended

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
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
//		self.id = try decoder.decode(Int64.self, forKey: .id)
//		let fields = try decoder.nestedContainer("fields")
		self.com2usId = try decoder.decode("com2usId")
		self.name = try decoder.decode("name")
		self.c2uDescription = try decoder.decode("c2uDescription")
		self.category = try decoder.decode("category")
		self.imageFilename = try decoder.decode("imageFilename")
		self.sellValue = try decoder.decode("sellValue")
		self.slug = try decoder.decode("slug")
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
}
