//
//  PlayerFile.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 3/23/21.
//

import Foundation

struct SummonerWrapper: Decodable {
	private enum CodingKeys: String, CodingKey {
		case wizard = "wizard_info"
	}
	var wizard: Summoner
}

public class PlayerFile: Decodable {

    public enum CodingKeys: String, CodingKey {
        case summoner = "wizard_info"
        case buildings = "deco_list"
        case monsters = "unit_list"
        case runes
        case artifacts
    }

    var summoner: Summoner?
    var buildings: [BuildingInstance] = []
    var monsters: [MonsterInstance] = []
    public var runes: [RuneInstance] = []
    public var artifacts: [ArtifactInstance] = []

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        self.init()
        print("Player file init starting")

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print("container set up")
        // and start decoding
        self.summoner = try container.decode(Summoner.self, forKey: .summoner)
        print("Summoner ok")
        self.buildings = try container.decodeArray(BuildingInstance.self, forKey: .buildings)
		print("Buildings imported")
		print("Importing monsters")
        self.monsters = try container.decodeArray(MonsterInstance.self, forKey: .monsters)
		print("Monsters imported")
		print("Importing runes")
		self.runes += try container.decodeArray(RuneInstance.self, forKey: .runes)
		print("Runes imported")
		print("Importing artifacts")
		self.artifacts = try container.decodeArray(ArtifactInstance.self, forKey: .artifacts)
		print("Artifacts imported")
    }
}

fileprivate struct DummyCodable: Codable {}

extension UnkeyedDecodingContainer {

    public mutating func decodeArray<T>(_ type: T.Type) throws -> [T] where T : Decodable {

        var array = [T]()
        while !self.isAtEnd {
            do {
                let item = try self.decode(T.self)
                array.append(item)
            } catch let error {
                print("error: \(error)")

                // hack to increment currentIndex
                _ = try self.decode(DummyCodable.self)
            }
        }
        return array
    }
}
extension KeyedDecodingContainerProtocol {
    public func decodeArray<T>(_ type: T.Type, forKey key: Self.Key) throws -> [T] where T : Decodable {
        var unkeyedContainer = try self.nestedUnkeyedContainer(forKey: key)
        return try unkeyedContainer.decodeArray(type)
    }
}
