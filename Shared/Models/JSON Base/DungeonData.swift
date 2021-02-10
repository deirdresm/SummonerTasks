//
//  DungeonData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/26/21.
//

import Foundation
import CoreData

// MARK: - Dungeon
struct DungeonData: Codable {
    let id, com2UsID: Int
    let enabled: Bool
    let name, slug: String
    let category: Int
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case com2UsID = "com2us_id"
        case enabled, name, slug, category, icon
    }
}

// MARK: Dungeon convenience initializers and mutators

extension DungeonData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DungeonData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        com2UsID: Int? = nil,
        enabled: Bool? = nil,
        name: String? = nil,
        slug: String? = nil,
        category: Int? = nil,
        icon: String? = nil
    ) -> DungeonData {
        return DungeonData(
            id: id ?? self.id,
            com2UsID: com2UsID ?? self.com2UsID,
            enabled: enabled ?? self.enabled,
            name: name ?? self.name,
            slug: slug ?? self.slug,
            category: category ?? self.category,
            icon: icon ?? self.icon
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Level
struct LevelData: Codable {
    let id, dungeon, floor, difficulty: Int
    let energyCost: Int
    let xp: JSONNull?
    let frontlineSlots: Int
    let backlineSlots: JSONNull?
    let totalSlots: Int

    enum CodingKeys: String, CodingKey {
        case id, dungeon, floor, difficulty
        case energyCost = "energy_cost"
        case xp
        case frontlineSlots = "frontline_slots"
        case backlineSlots = "backline_slots"
        case totalSlots = "total_slots"
    }
}

// MARK: Level convenience initializers and mutators

extension LevelData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LevelData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        dungeon: Int? = nil,
        floor: Int? = nil,
        difficulty: Int? = nil,
        energyCost: Int? = nil,
        xp: JSONNull?? = nil,
        frontlineSlots: Int? = nil,
        backlineSlots: JSONNull?? = nil,
        totalSlots: Int? = nil
    ) -> LevelData {
        return LevelData(
            id: id ?? self.id,
            dungeon: dungeon ?? self.dungeon,
            floor: floor ?? self.floor,
            difficulty: difficulty ?? self.difficulty,
            energyCost: energyCost ?? self.energyCost,
            xp: xp ?? self.xp,
            frontlineSlots: frontlineSlots ?? self.frontlineSlots,
            backlineSlots: backlineSlots ?? self.backlineSlots,
            totalSlots: totalSlots ?? self.totalSlots
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: Enemy convenience initializers and mutators

extension EnemyData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EnemyData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        order: Int? = nil,
        wave: Int? = nil,
        monster: Int? = nil,
        com2UsID: Int? = nil,
        boss: Bool? = nil,
        stars: Int? = nil,
        level: Int? = nil,
        hp: Int? = nil,
        attack: Int? = nil,
        defense: Int? = nil,
        speed: Int? = nil,
        resist: Int? = nil,
        accuracyBonus: Int? = nil,
        critBonus: Int? = nil,
        critDamageReduction: Int? = nil
    ) -> EnemyData {
        return EnemyData(
            id: id ?? self.id,
            order: order ?? self.order,
            wave: wave ?? self.wave,
            monster: monster ?? self.monster,
            com2UsID: com2UsID ?? self.com2UsID,
            boss: boss ?? self.boss,
            stars: stars ?? self.stars,
            level: level ?? self.level,
            hp: hp ?? self.hp,
            attack: attack ?? self.attack,
            defense: defense ?? self.defense,
            speed: speed ?? self.speed,
            resist: resist ?? self.resist,
            accuracyBonus: accuracyBonus ?? self.accuracyBonus,
            critBonus: critBonus ?? self.critBonus,
            critDamageReduction: critDamageReduction ?? self.critDamageReduction
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
