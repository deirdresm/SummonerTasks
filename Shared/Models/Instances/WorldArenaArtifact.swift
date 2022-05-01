//
//  WorldArenaArtifact.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 4/16/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let worldArenaArtifact = try WorldArenaArtifact(json)

import Foundation

// MARK: - WorldArenaArtifact
class WorldArenaArtifact: Codable {
	var worldArenaArtifactEquipList: [WorldArenaArtifactEquipList]

	enum CodingKeys: String, CodingKey {
		case worldArenaArtifactEquipList = "world_arena_artifact_equip_list"
	}

	init(worldArenaArtifactEquipList: [WorldArenaArtifactEquipList]) {
		self.worldArenaArtifactEquipList = worldArenaArtifactEquipList
	}
}

// MARK: WorldArenaArtifact convenience initializers and mutators

extension WorldArenaArtifact {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(WorldArenaArtifact.self, from: data)
		self.init(worldArenaArtifactEquipList: me.worldArenaArtifactEquipList)
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
		worldArenaArtifactEquipList: [WorldArenaArtifactEquipList]? = nil
	) -> WorldArenaArtifact {
		return WorldArenaArtifact(
			worldArenaArtifactEquipList: worldArenaArtifactEquipList ?? self.worldArenaArtifactEquipList
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// WorldArenaArtifactEquipList.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let worldArenaArtifactEquipList = try WorldArenaArtifactEquipList(json)

import Foundation

// MARK: - WorldArenaArtifactEquipList
class WorldArenaArtifactEquipList: Codable {
	var rid, wizardID, artifactID, artifactType: Int
	var occupiedID, slot, contentType: Int

	enum CodingKeys: String, CodingKey {
		case rid
		case wizardID = "wizard_id"
		case artifactID = "artifact_id"
		case artifactType = "artifact_type"
		case occupiedID = "occupied_id"
		case slot
		case contentType = "content_type"
	}

	init(rid: Int, wizardID: Int, artifactID: Int, artifactType: Int, occupiedID: Int, slot: Int, contentType: Int) {
		self.rid = rid
		self.wizardID = wizardID
		self.artifactID = artifactID
		self.artifactType = artifactType
		self.occupiedID = occupiedID
		self.slot = slot
		self.contentType = contentType
	}
}

// MARK: WorldArenaArtifactEquipList convenience initializers and mutators

extension WorldArenaArtifactEquipList {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(WorldArenaArtifactEquipList.self, from: data)
		self.init(rid: me.rid, wizardID: me.wizardID, artifactID: me.artifactID, artifactType: me.artifactType, occupiedID: me.occupiedID, slot: me.slot, contentType: me.contentType)
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
		rid: Int? = nil,
		wizardID: Int? = nil,
		artifactID: Int? = nil,
		artifactType: Int? = nil,
		occupiedID: Int? = nil,
		slot: Int? = nil,
		contentType: Int? = nil
	) -> WorldArenaArtifactEquipList {
		return WorldArenaArtifactEquipList(
			rid: rid ?? self.rid,
			wizardID: wizardID ?? self.wizardID,
			artifactID: artifactID ?? self.artifactID,
			artifactType: artifactType ?? self.artifactType,
			occupiedID: occupiedID ?? self.occupiedID,
			slot: slot ?? self.slot,
			contentType: contentType ?? self.contentType
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}
