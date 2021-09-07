//
//  RuneInstance+CoreDataClass.swift
//  
//
//  Created by Deirdre Saoirse Moen on 1/24/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(RuneInstance)
public class RuneInstance: NSManagedObject, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "rune_id"
        case summonerId = "wizard_id"
        case occupiedType = "occupied_type"
        case assignedToId = "occupied_id"
        case slot = "slot_no"
        case level = "upgrade_curr"
        case stars = "class"
//        case setId
        case runeType = "set_id"
        case upgradeLimit = "upgrade_limit"
//        case upgradeCurr = "upgrade_curr"
//        case baseValue = "base_value"
        case runeValue = "sell_value"
        case priEff = "pri_eff"
        case prefixEff = "prefix_eff"
        case secEff = "sec_eff"
        case quality = "rank"
        case originalQuality = "extra"
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for RuneInstance]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "RuneInstance", in: context) else { fatalError("Could not get entity [for RuneInstance]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.summoner = Summoner.findById(self.summonerId, context: context)
//        self.occupiedType = try container.decode(Int64.self, forKey: .occupiedType)
        self.assignedToId = try container.decode(Int64.self, forKey: .assignedToId)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.slot = try container.decode(Int16.self, forKey: .slot)
        self.level = try container.decode(Int16.self, forKey: .level)
        self.stars = try container.decode(Int16.self, forKey: .stars)
        self.quality = try container.decode(Int16.self, forKey: .quality)
        
        // parse whether it's an ancient rune or not
        let originalQuality = try container.decode(Int16.self, forKey: .originalQuality)
        if originalQuality < 10 {
            self.originalQuality = originalQuality
            self.ancient = false
        } else {
            self.originalQuality = originalQuality - 10
            self.ancient = true
        }
        
        self.runeType = try container.decode(Int16.self, forKey: .runeType)
        self.runeValue = try container.decode(Int32.self, forKey: .runeValue)
        
        let priEff = try container.decode([Int32].self, forKey: .priEff)
        self.mainStat = Int16(priEff[0])
        self.mainStatValue = Int64(priEff[1])
        
        let prefixEff = try container.decode([Int32].self, forKey: .prefixEff)
        self.innateStat = Int64(prefixEff[0])
        self.innateStatValue = Int64(prefixEff[1])
        
        let secEff = try container.decode([[Int32]].self, forKey: .secEff)
    }
}
