//
//  RuneInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData

public struct RuneInstanceData: JsonArray {
    
    static var items = [RuneInstanceData]()

    private enum CodingKeys: String, CodingKey {
        case id = "rune_id"
        case summonerId = "wizard_id"
        case occupiedType = "occupied_type"
        case occupiedId = "occupied_id"
        case slot = "slot_no"
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
        case originalQuality
    }

    let id:                 Int64
    let summonerId:         Int64
    let occupiedType:       Int64
    let monsterInstanceId:  Int64?
    let slot:               Int64
    let rank:               Int64
    let runeClass:          Int64
    let setId:              Int64
    let upgradeLimit:       Int64
    let upgradeCurr:        Int64
    let baseValue:          Int64
    let sellValue:          Int64
    var priEff:             [Int64]
    var prefixEff:          [Int64]
    var secEff:             [[Int64]] = [[]]
    let originalQuality:    Int64

    public init(rune: JSON) {
        id = rune.rune_id.int
        summonerId = rune.wizard_id.int
        occupiedType = rune.occupied_type.int
        monsterInstanceId = rune.occupied_id.int
        slot = rune.slot_no.int
        rank = rune.rank.int // stars
        runeClass = rune.class.int
        setId = rune.set_id.int
        upgradeLimit = rune.upgrade_limit.int
        upgradeCurr = rune.upgrade_curr.int
        baseValue = rune.base_value.int
        sellValue = rune.sell_value.int
        originalQuality = rune.extra.int // original rune quality
        
        //        var jsonArr = building.fields.stat_bonus.value
        //        var converted = try! JSON(string: jsonArr as! String).array
        //        statBonus = converted.map {try! JSON(string: $0.value as! String).int}


        var jsonArr = rune.pri_eff.value
//        var converted = try! JSON(string: jsonArr as! String).array
//        priEff = converted.map {try! JSON(string: $0.value as! String).int}
        priEff = jsonArr as! [Int64]

//        print("priEff: \(priEff)")

        jsonArr = rune.prefix_eff.value
//        converted = try! JSON(string: jsonArr as! String).array
//        prefixEff = converted.map {try! JSON(string: $0.value as! String).int}
        prefixEff = jsonArr as! [Int64]
//        print("prefixEff: \(prefixEff)")

        var jsonArr2 = rune.sec_eff.value
        secEff = jsonArr2 as! [[Int64]]
//        var converted = try! JSON(string: jsonArr2 as! String).array

//        let convertedArray = Array(converted)
//        for index in convertedArray {
//            let ci = convertedArray[index]
//            let se = ci.map {try! JSON(string: $0.value as! String).int}
//            secEff.append(se)
//        }
//        print("secEff: \(secEff)")

//        jsonArr = rune.prefixEff.value
//        converted = try! JSON(string: jsonArr as! String).array
//        prefixEff =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("prefixEff: \(prefixEff)")
//
//        jsonArr = rune.upgrade_cost.value
//        converted = try! JSON(string: jsonArr as! String).array
//        upgradeCost =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("upgradeCost: \(upgradeCost)")
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            RuneInstance.batchUpdate(from: RuneInstanceData.items,
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
