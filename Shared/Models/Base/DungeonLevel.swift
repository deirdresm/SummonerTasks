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
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "DungeonLevel", in: context) else { fatalError("Could not get entity [for DungeonLevel]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)
		// start decoding
		self.dungeonId = (fields["dungeon"]).orInt
		self.floor = (fields["floor"]).orInt16
		self.difficulty = (fields["difficulty"]).orInt16
		self.energyCost = (fields["energy_cost"]).orInt16

		self.xp = (fields["xp"]).orOptionalInt
		self.frontlineSlots = (fields["frontline_slots"]).orInt16
		self.backlineSlots = (fields["backline_slots"]).orOptionalInt
		self.totalSlots = (fields["total_slots"]).orInt16
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

}
