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
