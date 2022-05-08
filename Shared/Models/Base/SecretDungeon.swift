//
//  SecretDungeon.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//


import Foundation
import CoreData

@objc(SecretDungeon)
public class SecretDungeon: NSManagedObject, Decodable {
	enum CodingKeys: String, CodingKey {
		case id
		case monsterId = "monster_id"
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "SecretDungeon", in: context) else { fatalError("Could not get entity [for SecretDungeon]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.monsterId = (fields["monster_id"]).orInt

		if let monster = Monster.findById(self.monsterId, context: context) {
			self.monster = monster
		}
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}
}
