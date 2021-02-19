//
//  BuildingInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let decoListData = try DecoListData(json)

import Foundation

// MARK: - DecoListData
struct DecoListData: Codable {
    let wizardID, decoID, masterID, islandID: Int
    let posX, posY, level: Int

    enum CodingKeys: String, CodingKey {
        case wizardID = "wizard_id"
        case decoID = "deco_id"
        case masterID = "master_id"
        case islandID = "island_id"
        case posX = "pos_x"
        case posY = "pos_y"
        case level
    }
}

// MARK: DecoListData convenience initializers and mutators

extension DecoListData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DecoListData.self, from: data)
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
        wizardID: Int? = nil,
        decoID: Int? = nil,
        masterID: Int? = nil,
        islandID: Int? = nil,
        posX: Int? = nil,
        posY: Int? = nil,
        level: Int? = nil
    ) -> DecoListData {
        return DecoListData(
            wizardID: wizardID ?? self.wizardID,
            decoID: decoID ?? self.decoID,
            masterID: masterID ?? self.masterID,
            islandID: islandID ?? self.islandID,
            posX: posX ?? self.posX,
            posY: posY ?? self.posY,
            level: level ?? self.level
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//public struct BuildingInstanceData: JsonArray {
//
//    static var items = [BuildingInstanceData]()
//
//    // for deco_list
//    // note: don't keep the island info
//
//    private enum CodingKeys: String, CodingKey {
//        case com2usId = "deco_id"
//        case summonerId = "wizard_id"
//        case buildingId = "master_id"
//        case level
//    }
//
//    let com2usId:    Int64
//    let summonerId:  Int64
//    let buildingId:  Int64
//    let level:       Int64
//
//    public init(building: JSON) {
//        com2usId = building.master_id.int
//        summonerId = building.wizard_id.int
//        buildingId = building.deco_id.int
//        level = building.level.int
//    }
//
//    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
//
//        docInfo.taskContext.perform {
//            BuildingInstance.batchUpdate(from: BuildingInstanceData.items,
//                                         docInfo: docInfo)
//            do {
//                if docInfo.taskContext.hasChanges {
//                    try docInfo.taskContext.save()
//                }
//                else
//                {
//                    print("No context changes for building instance data.")
//                }
//
//            } catch {
//                print("could not save context")
//            }
//        }
//    }
//}

/*     {
 
 // storage building
 "building_id": 333041320,
 "wizard_id": 12345678,
 "island_id": 7,
 "building_master_id": 25,
 "pos_x": 9,
 "pos_y": 6,
 "gain_per_hour": 0
},

 //  water tower definition with the level from deco
 {
   "wizard_id": 12345678,
   "deco_id": 20456096,
   "master_id": 16,
   "island_id": 6,
   "pos_x": 16,
   "pos_y": 8,
   "level": 2
 },

*/
