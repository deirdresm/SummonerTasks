//
//  MonsterInstanceData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/20.
//

import Foundation

public struct MonsterInstanceData {
    private enum CodingKeys: String, CodingKey {
        case com2usId = "rune_id"
        case summonerId = "wizard_id"
    }
    
    let com2usId:           Int64
    let summonerId:         Int64

    public init(monster: JSON) {
        com2usId = monster.fields.rune_id.int
        summonerId = monster.fields.wizard_id.int
    }
}
