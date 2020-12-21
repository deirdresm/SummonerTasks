//
//  RuneInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation

public struct RuneInstanceData {
    
    // for deco_list
    // note: don't keep the island info

    private enum CodingKeys: String, CodingKey {
        case com2usId = "rune_id"
        case summonerId = "wizard_id"
        case occupiedType = "occupied_type"
        case occupiedId = "occupied_id"
        case slotNo = "slot_no"
        case rank
        case runeClass = "class"
        case setId = "set_id"
        case upgradeLimit = "upgrade_limit"
        case upgradeCurr = "upgrade_curr"
        case baseValue = "base_value"
        case sellValue = "sell_value"
        case priEff = "pri_eff"
        case prefixEff = "prefix_eff"
        case secEff = "sec_eff"
        case extra
    }

    let com2usId:           Int64
    let summonerId:         Int64
    let occupiedType:       Int64
    let monsterInstanceId:  Int64
    let slotNo:             Int64
    let rank:               Int64
    let runeClass:          Int64
    let setId:              Int64
    let upgradeLimit:       Int64
    let upgradeCurr:        Int64
    let baseValue:          Int64
    let sellValue:          Int64
    var priEff:             [Int64]
    var prefixEff:          [[Int64]]?
    var secEff:             [Int64]?
    let extra:              Int64

    public init(rune: JSON) {
        com2usId = rune.fields.rune_id.int
        summonerId = rune.fields.wizard_id.int
        occupiedType = rune.fields.occupied_type.int
        monsterInstanceId = rune.fields.occupied_id.int
        slotNo = rune.fields.slotNo.int
        rank = rune.fields.rank.int
        runeClass = rune.fields.rune_class.int
        setId = rune.fields.set_id.int
        upgradeLimit = rune.fields.upgrade_limit.int
        upgradeCurr = rune.fields.upgrade_curr.int
        baseValue = rune.fields.base_value.int
        sellValue = rune.fields.sell_value.int
        extra = rune.fields.extra.int // original rune quality

        var jsonArr = rune.fields.priEff.value
        var converted = try! JSON(string: jsonArr as! String).array
        priEff = converted.map {try! JSON(string: $0.value as! String).int}
        print("priEff: \(priEff)")

//        jsonArr = rune.fields.prefixEff.value
//        converted = try! JSON(string: jsonArr as! String).array
//        prefixEff =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("prefixEff: \(prefixEff)")
//
//        jsonArr = rune.fields.upgrade_cost.value
//        converted = try! JSON(string: jsonArr as! String).array
//        upgradeCost =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("upgradeCost: \(upgradeCost)")
    }
}
