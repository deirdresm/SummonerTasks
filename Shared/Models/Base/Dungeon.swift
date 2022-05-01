//
//  Dungeon.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 10/29/21.
//

import Foundation
import CoreData

@objc(Dungeon)
public class Dungeon: NSManagedObject, Decodable {

	enum CodingKeys: String, CodingKey {
		case id = "com2us_id"
		case enabled, name, slug, category
		case imageFilename = "icon"
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.enabled = try container.decode(Bool.self, forKey: .enabled)
		self.category = try container.decode(Int16.self, forKey: .category)
		self.imageFilename = try container.decode(String.self, forKey: .imageFilename)
		self.name = try container.decode(String.self, forKey: .name)

	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}
}
