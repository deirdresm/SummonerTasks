//
//  ArtifactInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/1/21.
//

import Foundation
import CoreData

public struct ArtifactInstanceData {
    
    private enum CodingKeys: String, CodingKey {
        case com2usId = "rid"
        case summonerId = "wizard_id"
        case monsterInstanceId = "occupied_id"
        case slot
        case artifactType = "artifact_type"
        case attribute
        case unitStyle
        case naturalRank
        case rank
        case level
        case primaryEffect
        case secondaryEffects
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

    public init(artifact: JSON) {
        com2usId = artifact.fields.rid.int
        summonerId = artifact.fields.wizard_id.int
        monsterInstanceId = artifact.fields.occupied_id.int
        slot = artifact.fields.slot.int
        artifactType = artifact.fields.artifact_type.int
        attribute = artifact.fields.attribute.int
        unitStyle = artifact.fields.unit_style.int
        naturalRank = artifact.fields.natural_rank.int
        rank = artifact.fields.rank.int
        level = artifact.fields.level.int
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
