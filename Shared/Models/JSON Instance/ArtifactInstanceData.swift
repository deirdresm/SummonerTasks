//
//  ArtifactInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/1/21.
//

import Foundation
import CoreData

public struct ArtifactStat: JsonArray {
    static var items = [ArtifactStat]()

    var stat: Int64
    var statValue: CGFloat
    var upgradeCount: Int64
    var rerollCount: Int64

    init(_ values: [Int64]) {
        stat = values[0]
        statValue = CGFloat(values[1])
        upgradeCount = values[2]
        rerollCount = values[3]
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        return
    }
}

public struct ArtifactInstanceData: JsonArray {
    
    static var items = [ArtifactInstanceData]()

    private enum CodingKeys: String, CodingKey {
        case com2usId = "rid"
        case summonerId = "wizard_id"
        case monsterInstanceId = "occupied_id"
        case slot = "type" // there's *also* a slot field, used for artifacts on monsters
        case artifactType = "artifact_type"
        case attribute
        case unitStyle = "unit_style"
        case naturalRank = "natural_rank"
        case rank
        case level
        case primaryEffect = "pri_effect"
//        case secondaryEffects = "sec_effects"
    }

    let com2usId:           Int64
    let summonerId:         Int64
    let monsterInstanceId:  Int64
    let slot:               Int64
    let artifactType:       Int64
    let attribute:          Int64
    let unitStyle:          Int64
    let naturalRank:        Int64
    let rank:               Int64
    let level:              Int64
    var primaryEffect:      [Int64]
//    var secondaryEffects:   [ArtifactStat]

    public init(artifact: JSON) {
        com2usId = artifact.rid.int
        summonerId = artifact.wizard_id.int
        monsterInstanceId = artifact.occupied_id.int
        slot = artifact.type.int
        artifactType = artifact.artifact_type.int
        attribute = artifact.attribute.int
        unitStyle = artifact.unit_style.int
        naturalRank = artifact.natural_rank.int
        rank = artifact.rank.int
        level = artifact.level.int

        var jsonArr = artifact.pri_effect.value
//        converted = try! JSON(string: jsonArr as! String).array
//        prefixEff = converted.map {try! JSON(string: $0.value as! String).int}
        primaryEffect = jsonArr as! [Int64]

//        var jsonArr2 = artifact.sec_effects.value
//        secondaryEffects = jsonArr2 as! [ArtifactStat]

    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            ArtifactInstance.batchUpdate(from: ArtifactInstanceData.items,
                                         docInfo: docInfo)
            do {
                if docInfo.taskContext.hasChanges {
                    try docInfo.taskContext.save()
                }

            } catch {
                print("could not save context")
            }
        }
    }
}

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
