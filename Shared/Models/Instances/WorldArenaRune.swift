//
//  WorldArenaRune.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 4/16/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let worldArenaRune = try WorldArenaRune(json)

import Foundation

// MARK: - WorldArenaRune
class WorldArenaRune: Codable {
	var worldArenaRuneEquipList: [WorldArenaRuneEquipList]

	enum CodingKeys: String, CodingKey {
		case worldArenaRuneEquipList = "world_arena_rune_equip_list"
	}

	init(worldArenaRuneEquipList: [WorldArenaRuneEquipList]) {
		self.worldArenaRuneEquipList = worldArenaRuneEquipList
	}
}

// MARK: WorldArenaRune convenience initializers and mutators

extension WorldArenaRune {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(WorldArenaRune.self, from: data)
		self.init(worldArenaRuneEquipList: me.worldArenaRuneEquipList)
	}

	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		worldArenaRuneEquipList: [WorldArenaRuneEquipList]? = nil
	) -> WorldArenaRune {
		return WorldArenaRune(
			worldArenaRuneEquipList: worldArenaRuneEquipList ?? self.worldArenaRuneEquipList
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// WorldArenaRuneEquipList.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let worldArenaRuneEquipList = try WorldArenaRuneEquipList(json)

import Foundation

// MARK: - WorldArenaRuneEquipList
class WorldArenaRuneEquipList: Codable {
	var runeID, occupiedID: Int

	enum CodingKeys: String, CodingKey {
		case runeID = "rune_id"
		case occupiedID = "occupied_id"
	}

	init(runeID: Int, occupiedID: Int) {
		self.runeID = runeID
		self.occupiedID = occupiedID
	}
}

// MARK: WorldArenaRuneEquipList convenience initializers and mutators

extension WorldArenaRuneEquipList {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(WorldArenaRuneEquipList.self, from: data)
		self.init(runeID: me.runeID, occupiedID: me.occupiedID)
	}

	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		runeID: Int? = nil,
		occupiedID: Int? = nil
	) -> WorldArenaRuneEquipList {
		return WorldArenaRuneEquipList(
			runeID: runeID ?? self.runeID,
			occupiedID: occupiedID ?? self.occupiedID
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}
