//
//  BuildingInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation

public struct BuildingInstanceData {
    
    // for deco_list
    // note: don't keep the island info

    private enum CodingKeys: String, CodingKey {
        case com2usId = "deco_id"
        case summonerId = "wizard_id"
        case buildingId = "master_id"
        case level
    }

    let com2usId:    Int64
    let summonerId:  Int64
    let buildingId:  Int64
    let level:       Int64

    public init(building: JSON) {
        com2usId = building.fields.com2us_id.int
        summonerId = building.fields.summonerId.int
        buildingId = building.fields.buildingId.int
        level = building.fields.level.int
    }
}
