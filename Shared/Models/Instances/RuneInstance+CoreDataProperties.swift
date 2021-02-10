//
//  RuneInstance+CoreDataProperties.swift
//  
//
//  Created by Deirdre Saoirse Moen on 1/24/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension RuneInstance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RuneInstance> {
        return NSFetchRequest<RuneInstance>(entityName: "RuneInstance")
    }

    @NSManaged public var accuracy: Int64
    @NSManaged public var ancient: Bool
    @NSManaged public var assignedToId: Int64
    @NSManaged public var atkFlat: Int64
    @NSManaged public var atkPct: Int64
    @NSManaged public var critDmg: Int64
    @NSManaged public var critRate: Int64
    @NSManaged public var defFlat: Int64
    @NSManaged public var defPct: Int64
    @NSManaged public var efficiency: Float
    @NSManaged public var hasAccuracy: Bool
    @NSManaged public var hasAtk: Bool
    @NSManaged public var hasCritDmg: Bool
    @NSManaged public var hasCritRate: Bool
    @NSManaged public var hasDef: Bool
    @NSManaged public var hasGem: Bool
    @NSManaged public var hasGrind: Bool
    @NSManaged public var hasHP: Bool
    @NSManaged public var hasResist: Bool
    @NSManaged public var hasSpeed: Bool
    @NSManaged public var hpFlat: Int64
    @NSManaged public var hpPct: Int64
    @NSManaged public var id: Int64
    @NSManaged public var innateStat: Int64
    @NSManaged public var innateStatValue: Int64
    @NSManaged public var level: Int64
    @NSManaged public var mainStat: Int64
    @NSManaged public var mainStatValue: Int64
    @NSManaged public var maxEfficiency: Float
    @NSManaged public var notes: String?
    @NSManaged public var originalQuality: Int64
    @NSManaged public var ownerId: Int64
    @NSManaged public var quality: Int64
    @NSManaged public var resistance: Int64
    @NSManaged public var runeType: Int64
    @NSManaged public var runeValue: Int64
    @NSManaged public var slot: Int64
    @NSManaged public var speed: Int64
    @NSManaged public var stars: Int64
    @NSManaged public var substat1: Int64
    @NSManaged public var substat1Craft: Int64
    @NSManaged public var substat1Enchanted: Bool
    @NSManaged public var substat1Value: Int64
    @NSManaged public var substat2: Int64
    @NSManaged public var substat2Craft: Int64
    @NSManaged public var substat2Enchanted: Bool
    @NSManaged public var substat2Value: Int64
    @NSManaged public var substat3: Int64
    @NSManaged public var substat3Craft: Int64
    @NSManaged public var substat3Enchanted: Bool
    @NSManaged public var substat3Value: Int64
    @NSManaged public var substat4: Int64
    @NSManaged public var substat4Craft: Int64
    @NSManaged public var substat4Enchanted: Bool
    @NSManaged public var substat4Value: Int64
    @NSManaged public var substats: Data?
    @NSManaged public var substatsEnchanted: Data?
    @NSManaged public var substatsGrindValue: Data?
    @NSManaged public var substatUpgradesRemaining: Int64
    @NSManaged public var substatValues: Data?
    @NSManaged public var summonerId: Int64
    @NSManaged public var monster: MonsterInstance?
    @NSManaged public var summoner: Summoner?

}

extension RuneInstance : Identifiable {

}
