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
		self.monsterId = try container.decode(Int64.self, forKey: .monsterId)
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
