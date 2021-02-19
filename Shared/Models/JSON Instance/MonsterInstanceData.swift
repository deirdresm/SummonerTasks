//
//  MonsterInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/20.
//

import Foundation
import CoreData

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let MonsterInstanceData = try MonsterInstanceData(json)

// MARK: - MonsterInstanceData
struct MonsterInstanceData: Codable {
    let unitID, wizardID, islandID, posX: Int
    let posY, buildingID, unitMasterID, unitLevel: Int
    let MonsterInstanceDataClass, con, atk, def: Int
    let spd, resist, accuracy, criticalRate: Int
    let criticalDamage, experience, expGained, expGainRate: Int
    let skills: [[Int]]
    let runes: [RuneInstanceData]
    let artifacts: [ArtifactInstanceData]
    let costumeMasterID: Int
    let transItems: [JSONAny]
    let attribute: Int
    let createTime: String
    let source, homunculus: Int
    let homunculusName: String
    let awakeningInfo: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case unitID = "unit_id"
        case wizardID = "wizard_id"
        case islandID = "island_id"
        case posX = "pos_x"
        case posY = "pos_y"
        case buildingID = "building_id"
        case unitMasterID = "unit_master_id"
        case unitLevel = "unit_level"
        case MonsterInstanceDataClass = "class"
        case con, atk, def, spd, resist, accuracy
        case criticalRate = "critical_rate"
        case criticalDamage = "critical_damage"
        case experience
        case expGained = "exp_gained"
        case expGainRate = "exp_gain_rate"
        case skills, runes, artifacts
        case costumeMasterID = "costume_master_id"
        case transItems = "trans_items"
        case attribute
        case createTime = "create_time"
        case source, homunculus
        case homunculusName = "homunculus_name"
        case awakeningInfo = "awakening_info"
    }
}

// MARK: MonsterInstanceData convenience initializers and mutators

extension MonsterInstanceData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MonsterInstanceData.self, from: data)
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
        unitID: Int? = nil,
        wizardID: Int? = nil,
        islandID: Int? = nil,
        posX: Int? = nil,
        posY: Int? = nil,
        buildingID: Int? = nil,
        unitMasterID: Int? = nil,
        unitLevel: Int? = nil,
        MonsterInstanceDataClass: Int? = nil,
        con: Int? = nil,
        atk: Int? = nil,
        def: Int? = nil,
        spd: Int? = nil,
        resist: Int? = nil,
        accuracy: Int? = nil,
        criticalRate: Int? = nil,
        criticalDamage: Int? = nil,
        experience: Int? = nil,
        expGained: Int? = nil,
        expGainRate: Int? = nil,
        skills: [[Int]]? = nil,
        runes: [Rune]? = nil,
        artifacts: [Artifact]? = nil,
        costumeMasterID: Int? = nil,
        transItems: [JSONAny]? = nil,
        attribute: Int? = nil,
        createTime: String? = nil,
        source: Int? = nil,
        homunculus: Int? = nil,
        homunculusName: String? = nil,
        awakeningInfo: [JSONAny]? = nil
    ) -> MonsterInstanceData {
        return MonsterInstanceData(
            unitID: unitID ?? self.unitID,
            wizardID: wizardID ?? self.wizardID,
            islandID: islandID ?? self.islandID,
            posX: posX ?? self.posX,
            posY: posY ?? self.posY,
            buildingID: buildingID ?? self.buildingID,
            unitMasterID: unitMasterID ?? self.unitMasterID,
            unitLevel: unitLevel ?? self.unitLevel,
            MonsterInstanceDataClass: MonsterInstanceDataClass ?? self.MonsterInstanceDataClass,
            con: con ?? self.con,
            atk: atk ?? self.atk,
            def: def ?? self.def,
            spd: spd ?? self.spd,
            resist: resist ?? self.resist,
            accuracy: accuracy ?? self.accuracy,
            criticalRate: criticalRate ?? self.criticalRate,
            criticalDamage: criticalDamage ?? self.criticalDamage,
            experience: experience ?? self.experience,
            expGained: expGained ?? self.expGained,
            expGainRate: expGainRate ?? self.expGainRate,
            skills: skills ?? self.skills,
            runes: runes ?? self.runes,
            artifacts: artifacts ?? self.artifacts,
            costumeMasterID: costumeMasterID ?? self.costumeMasterID,
            transItems: transItems ?? self.transItems,
            attribute: attribute ?? self.attribute,
            createTime: createTime ?? self.createTime,
            source: source ?? self.source,
            homunculus: homunculus ?? self.homunculus,
            homunculusName: homunculusName ?? self.homunculusName,
            awakeningInfo: awakeningInfo ?? self.awakeningInfo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AwakeningInfoData
struct AwakeningInfoData: Codable {
    let rid, wizardID, unitID, unitMasterID: Int
    let awakenMasterID, exp, isAwakened: Int
    let dateMod, dateAdd: String
    let maxExp: Int

    enum CodingKeys: String, CodingKey {
        case rid
        case wizardID = "wizard_id"
        case unitID = "unit_id"
        case unitMasterID = "unit_master_id"
        case awakenMasterID = "awaken_master_id"
        case exp
        case isAwakened = "is_awakened"
        case dateMod = "date_mod"
        case dateAdd = "date_add"
        case maxExp = "max_exp"
    }
}

// MARK: AwakeningInfoData convenience initializers and mutators

extension AwakeningInfoData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AwakeningInfoData.self, from: data)
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
        unitID: Int? = nil,
        unitMasterID: Int? = nil,
        awakenMasterID: Int? = nil,
        exp: Int? = nil,
        isAwakened: Int? = nil,
        dateMod: String? = nil,
        dateAdd: String? = nil,
        maxExp: Int? = nil
    ) -> AwakeningInfoData {
        return AwakeningInfoData(
            rid: rid ?? self.rid,
            wizardID: wizardID ?? self.wizardID,
            unitID: unitID ?? self.unitID,
            unitMasterID: unitMasterID ?? self.unitMasterID,
            awakenMasterID: awakenMasterID ?? self.awakenMasterID,
            exp: exp ?? self.exp,
            isAwakened: isAwakened ?? self.isAwakened,
            dateMod: dateMod ?? self.dateMod,
            dateAdd: dateAdd ?? self.dateAdd,
            maxExp: maxExp ?? self.maxExp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}




public struct MonsterInstanceSkillData {
    private enum CodingKeys: String, CodingKey {
        case skillId
        case level
    }
    
    let skillId:             Int64
    let level:               Int64

    public init(_ skillId: Int64, _ level: Int64) {
        self.skillId = skillId
        self.level = level
    }
    
    public init(ints: [Int64]) {
        self.skillId = ints[0]
        self.level = ints[1]
    }
}

//public struct MonsterInstanceData: JsonArray {
//
//    static var items = [MonsterInstanceData]()
//
//    private enum CodingKeys: String, CodingKey {
//        case id = "unit_id"
//        case summonerId = "wizard_id"
//        case monsterId = "unit_master_id"
//        case unitLevel = "unit_level"
//        case stars = "class"
//        case con
//        case atk
//        case def
//        case spd
//        case resist
//        case accuracy
//        case critRate = "critical_rate"
//        case critDamage = "critical_damage"
//        case skills
//        case runes
//        case artifacts
//    }
//
//    let id:                 Int64
//    let summonerId:         Int64   // points to Summoner object
//    let monsterId:          Int64   // points to Monster object
//    let unitLevel:          Int64
//    let stars:              Int64
//    let con:                Int64
//    let atk:                Int64
//    let def:                Int64
//    let spd:                Int64
//    let resist:             Int64
//    let accuracy:           Int64
//    let critRate:           Int64
//    let critDamage:         Int64
//    var skills:             [MonsterInstanceSkillData]
//    var runes:              [RuneInstanceData]
//    var artifacts:          [ArtifactInstanceData]
//
//    public init(monster: JSON) {
//        id = monster.unit_id.int
//        summonerId = monster.wizard_id.int
//        monsterId = monster.unit_master_id.int
//        unitLevel = monster.unit_level.int
//        stars = monster.class.int
//        con = monster.con.int
//        atk = monster.atk.int
//        def = monster.def.int
//        spd = monster.speed.int
//        resist = monster.resist.int
//        accuracy = monster.accuracy.int
//        critRate = monster.critical_rate.int
//        critDamage = monster.critical_damage.int
//
//        var jsonArr = monster.skills.value
//        var intIntArray = jsonArr as! [[Int64]]
//
//        // TODO: figure out why here, of all places, it's
//        // converting to [Int64] without having to kick it
//
//        skills = []
//        for array in intIntArray {
//            let misd = MonsterInstanceSkillData(ints: array)
//            skills.append(misd)
//        }
//
//        runes = []
//        let runeList = monster.runes.array
//        for rawRune in runeList {
//            let parsedRune = RuneInstanceData(rune: rawRune)
//            runes.append(parsedRune)
//        }
//
//        artifacts = []
//        let artifactList = monster.artifacts.array
//        for rawArtifact in artifactList {
//            let parsedArtifact = ArtifactInstanceData(artifact: rawArtifact)
//            artifacts.append(parsedArtifact)
//        }
//    }
//
//    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
//
//        docInfo.taskContext.perform {
//            MonsterInstance.batchUpdate(from: MonsterInstanceData.items,
//                                 docInfo: docInfo)
//            do {
//                if docInfo.taskContext.hasChanges {
//                    print("Saving context after adding monster instances.")
//                    try docInfo.taskContext.save()
//                }
//
//            } catch {
//                print("could not save context")
//            }
//        }
//    }
//}

/*     {
 "unit_id": 14591153200,
 "wizard_id": 29593827,
 "island_id": 7,
 "pos_x": 26,
 "pos_y": 2,
 "building_id": 0,
 "unit_master_id": 22612,
 "unit_level": 40,
 "class": 6,
 "con": 681,
 "atk": 790,
 "def": 670,
 "spd": 102,
 "resist": 15,
 "accuracy": 0,
 "critical_rate": 30,
 "critical_damage": 50,
 "experience": 1005420,
 "exp_gained": 0,
 "exp_gain_rate": 0,
 "skills": [
   [
     13102,
     9
   ],
   [
     13107,
     1
   ],
   [
     13112,
     4
   ]
 ],
 "runes": [
   {
     "rune_id": 28983545590,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 1,
     "rank": 5,
     "class": 6,
     "set_id": 15,
     "upgrade_limit": 15,
     "upgrade_curr": 15,
     "base_value": 602300,
     "sell_value": 32251,
     "pri_eff": [
       3,
       160
     ],
     "prefix_eff": [
       0,
       0
     ],
     "sec_eff": [
       [
         9,
         18,
         0,
         0
       ],
       [
         10,
         5,
         1,
         0
       ],
       [
         11,
         7,
         0,
         0
       ],
       [
         2,
         7,
         0,
         0
       ]
     ],
     "extra": 4
   },
   {
     "rune_id": 34481116710,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 2,
     "rank": 5,
     "class": 6,
     "set_id": 5,
     "upgrade_limit": 15,
     "upgrade_curr": 15,
     "base_value": 760800,
     "sell_value": 38040,
     "pri_eff": [
       4,
       63
     ],
     "prefix_eff": [
       9,
       6
     ],
     "sec_eff": [
       [
         6,
         13,
         0,
         5
       ],
       [
         11,
         4,
         0,
         0
       ],
       [
         8,
         11,
         0,
         2
       ],
       [
         2,
         12,
         0,
         0
       ]
     ],
     "extra": 4
   },
   {
     "rune_id": 33555457101,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 3,
     "rank": 5,
     "class": 6,
     "set_id": 15,
     "upgrade_limit": 15,
     "upgrade_curr": 14,
     "base_value": 475500,
     "sell_value": 25461,
     "pri_eff": [
       5,
       134
     ],
     "prefix_eff": [
       0,
       0
     ],
     "sec_eff": [
       [
         9,
         10,
         0,
         0
       ],
       [
         8,
         10,
         0,
         0
       ],
       [
         6,
         7,
         0,
         0
       ],
       [
         2,
         12,
         1,
         0
       ]
     ],
     "extra": 3
   },
   {
     "rune_id": 30340544965,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 4,
     "rank": 5,
     "class": 6,
     "set_id": 5,
     "upgrade_limit": 15,
     "upgrade_curr": 15,
     "base_value": 627660,
     "sell_value": 31383,
     "pri_eff": [
       10,
       80
     ],
     "prefix_eff": [
       0,
       0
     ],
     "sec_eff": [
       [
         4,
         19,
         0,
         0
       ],
       [
         9,
         10,
         0,
         0
       ],
       [
         2,
         7,
         0,
         6
       ],
       [
         6,
         8,
         1,
         5
       ]
     ],
     "extra": 5
   },
   {
     "rune_id": 32467237118,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 5,
     "rank": 5,
     "class": 6,
     "set_id": 5,
     "upgrade_limit": 15,
     "upgrade_curr": 15,
     "base_value": 608640,
     "sell_value": 30432,
     "pri_eff": [
       1,
       2448
     ],
     "prefix_eff": [
       9,
       5
     ],
     "sec_eff": [
       [
         8,
         6,
         0,
         3
       ],
       [
         2,
         5,
         0,
         0
       ],
       [
         10,
         27,
         0,
         0
       ],
       [
         5,
         29,
         0,
         0
       ]
     ],
     "extra": 5
   },
   {
     "rune_id": 34876777618,
     "wizard_id": 29593827,
     "occupied_type": 1,
     "occupied_id": 14591153200,
     "slot_no": 6,
     "rank": 5,
     "class": 6,
     "set_id": 5,
     "upgrade_limit": 15,
     "upgrade_curr": 12,
     "base_value": 592790,
     "sell_value": 29639,
     "pri_eff": [
       4,
       47
     ],
     "prefix_eff": [
       0,
       0
     ],
     "sec_eff": [
       [
         10,
         13,
         0,
         0
       ],
       [
         8,
         23,
         0,
         0
       ],
       [
         3,
         17,
         0,
         0
       ],
       [
         9,
         5,
         0,
         0
       ]
     ],
     "extra": 5
   }
 ],
 "artifacts": [
   {
     "rid": 26845935,
     "wizard_id": 29593827,
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
   {
     "rid": 28017055,
     "wizard_id": 29593827,
     "occupied_id": 14591153200,
     "slot": 1,
     "type": 1,
     "attribute": 2,
     "unit_style": 0,
     "natural_rank": 3,
     "rank": 5,
     "level": 14,
     "pri_effect": [
       101,
       66,
       14,
       0,
       0
     ],
     "sec_effects": [
       [
         209,
         3,
         0,
         0,
         0
       ],
       [
         207,
         11,
         2,
         0,
         0
       ],
       [
         216,
         3,
         0,
         0,
         0
       ],
       [
         306,
         4,
         0,
         0,
         0
       ]
     ],
     "locked": 0,
     "source": 50001,
     "extra": [],
     "date_add": "2020-09-06 20:42:34",
     "date_mod": "2020-12-12 15:58:20"
   }

 */
