//
//  DungeonLevel.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//

import Foundation
import CoreData

@objc(DungeonLevel)
public class DungeonLevel: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case dungeon
		case floor
		case difficulty
		case energyCost = "energy_cost"
		case xp
		case frontlineSlots = "frontline_slots"
		case backlineSlots = "backline_slots"
		case totalSlots = "total_slots"
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
		self.dungeonId = try container.decode(Int64.self, forKey: .dungeon)
		self.floor = try container.decode(Int16.self, forKey: .floor)
		self.difficulty = try container.decode(Int16.self, forKey: .difficulty)
		self.energyCost = try container.decode(Int16.self, forKey: .energyCost)
		self.xp = try container.decode(Int64.self, forKey: .xp)
		self.frontlineSlots = try container.decode(Int16.self, forKey: .frontlineSlots)
		self.backlineSlots = try container.decode(Int16.self, forKey: .backlineSlots)
		self.totalSlots = try container.decode(Int16.self, forKey: .totalSlots)
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

}
