//
//  ArtifactInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/1/21.
//

import Foundation
import CoreData

struct ArtifactInstanceData: Codable {
    let rid, wizardID, occupiedID, slot: Int
    let type, attribute, unitStyle, naturalRank: Int
    let rank, level: Int
    let priEffect: [Int]
    let secEffects: [[Int]]
    let locked, source: Int
    let extra: [JSONAny]
    let dateAdd, dateMod: String

    enum CodingKeys: String, CodingKey {
        case rid
        case wizardID = "wizard_id"
        case occupiedID = "occupied_id"
        case slot, type, attribute
        case unitStyle = "unit_style"
        case naturalRank = "natural_rank"
        case rank, level
        case priEffect = "pri_effect"
        case secEffects = "sec_effects"
        case locked, source, extra
        case dateAdd = "date_add"
        case dateMod = "date_mod"
    }
}

// MARK: Artifact convenience initializers and mutators

extension ArtifactInstanceData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArtifactInstanceData.self, from: data)
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
        rid: Int? = nil,
        wizardID: Int? = nil,
        occupiedID: Int? = nil,
        slot: Int? = nil,
        type: Int? = nil,
        attribute: Int? = nil,
        unitStyle: Int? = nil,
        naturalRank: Int? = nil,
        rank: Int? = nil,
        level: Int? = nil,
        priEffect: [Int]? = nil,
        secEffects: [[Int]]? = nil,
        locked: Int? = nil,
        source: Int? = nil,
        extra: [JSONAny]? = nil,
        dateAdd: String? = nil,
        dateMod: String? = nil
    ) -> ArtifactInstanceData {
        return ArtifactInstanceData(
            rid: rid ?? self.rid,
            wizardID: wizardID ?? self.wizardID,
            occupiedID: occupiedID ?? self.occupiedID,
            slot: slot ?? self.slot,
            type: type ?? self.type,
            attribute: attribute ?? self.attribute,
            unitStyle: unitStyle ?? self.unitStyle,
            naturalRank: naturalRank ?? self.naturalRank,
            rank: rank ?? self.rank,
            level: level ?? self.level,
            priEffect: priEffect ?? self.priEffect,
            secEffects: secEffects ?? self.secEffects,
            locked: locked ?? self.locked,
            source: source ?? self.source,
            extra: extra ?? self.extra,
            dateAdd: dateAdd ?? self.dateAdd,
            dateMod: dateMod ?? self.dateMod
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



//public struct ArtifactInstanceData: JsonArray {
//    
//    static var items = [ArtifactInstanceData]()
//
//    private enum CodingKeys: String, CodingKey {
//        case com2usId = "rid"
//        case summonerId = "wizard_id"
//        case monsterInstanceId = "occupied_id"
//        case slot
//        case artifactType = "artifact_type"
//        case attribute
//        case unitStyle = "unit_style"
//        case naturalRank = "natural_rank"
//        case rank
//        case level
//        case primaryEffect = "primary_effect"
//        case secondaryEffects = "secondary_effects"
//    }
//
//    let com2usId:           Int64
//    let summonerId:         Int64
//    let monsterInstanceId:  Int64
//    let slot:               Int64
//    let artifactType:       Int64
//    let attribute:          Int64
//    let unitStyle:          Int64
//    let naturalRank:        Int64
//    let rank:               Int64
//    let level:              Int64
//
//    public init(artifact: JSON) {
//        com2usId = artifact.rid.int
//        summonerId = artifact.wizard_id.int
//        monsterInstanceId = artifact.occupied_id.int
//        slot = artifact.slot.int
//        artifactType = artifact.artifact_type.int
//        attribute = artifact.attribute.int
//        unitStyle = artifact.unit_style.int
//        naturalRank = artifact.natural_rank.int
//        rank = artifact.rank.int
//        level = artifact.level.int
//    }
//    
//    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
//        
//        docInfo.taskContext.perform {
//            ArtifactInstance.batchUpdate(from: ArtifactInstanceData.items,
//                                         docInfo: docInfo)
//            do {
//                if docInfo.taskContext.hasChanges {
//                    try docInfo.taskContext.save()
//                }
//
//            } catch {
//                print("could not save context")
//            }
//        }
//    }
//}

/*
 "artifacts": [
   {
     "rid": 26845935,
     "wizard_id": 12345678,
     "occupied_id": 14591153200,
     "slot": 2,
     "type": 2,
     "attribute": 0,
     "unit_style": 1,
     "natural_rank": 3,
     "rank": 5,
     "level": 15,
     "pri_effect": [
       101,
       100,
       15,
       0,
       0
     ],
     "sec_effects": [
       [
         204,
         4,
         0,
         0,
         2
       ],
       [
         409,
         13,
         2,
         0,
         0
       ],
       [
         213,
         3,
         0,
         0,
         0
       ],
       [
         214,
         3,
         0,
         0,
         0
       ]
     ],
     "locked": 0,
     "source": 50001,
     "extra": [],
     "date_add": "2020-09-03 14:39:23",
     "date_mod": "2020-12-16 18:00:25"
   },
*/
