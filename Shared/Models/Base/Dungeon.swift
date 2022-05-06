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
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "Dungeon", in: context) else { fatalError("Could not get entity [for Dungeon]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.id = (fields["com2us_id"]).orInt
		self.enabled = (fields["enabled"]).orFalse
		self.name = (fields["name"]).orEmpty
		self.slug = (fields["slug"]).orEmpty
		self.category = (fields["category"]).orInt16
		self.imageFilename = (fields["icon"]).orEmpty
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk		// in practice, same as the com2us_id for this entity.
	}
}
