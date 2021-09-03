//
//  RuneInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData
import SwiftUI

// MARK: - Core Data

// MARK: - JSON

class HasRuneStat {
    var hasHp = false
    var hasAtk = false
    var hasDef = false
    var hasSpeed = false
    var hasCritRate = false
    var hasCritDmg = false
    var hasResist = false
    var hasAcc = false
    
    func setFlag(_ stat: RuneStatType) {
        switch stat {
        case .hpFlat, .hpPct:
            hasHp = true
        case .atkFlat, .atkPct:
            hasAtk = true
        case .defFlat, .defPct:
            hasDef = true
        case .speed:
            hasSpeed = true
        case .critRatePct:
            hasCritRate = true
        case .critDmgPct:
            hasCritDmg = true
        case .resistPct:
            hasResist = true
        case .accuracyPct:
            hasAcc = true
        }
    }
}


extension RuneInstance {
    
    func findById(summoner: Summoner, runeId: Int64,
                  context: NSManagedObjectContext) -> RuneInstance? {
        
//        PersistenceController.shared.container.viewContext.fetch
        guard let model =
                context.persistentStoreCoordinator?.managedObjectModel,
          let request = model
            .fetchRequestFromTemplate(withName: "summonerRuneById", substitutionVariables: ["id" : runeId, "summonerId": summoner.id])
            as? NSFetchRequest<RuneInstance> else {
              return nil
        }

        do {
            let runes = try context.fetch(request)
            
            if runes.count > 0 {
                return runes.first
            } else {
                
                let rune = NSEntityDescription.insertNewObject(
                    forEntityName: "RuneInstance",
                    into: context) as! RuneInstance
                rune.summonerId = summoner.id
                rune.id = runeId

                if context.hasChanges {
                    do {
                        if context.hasChanges {
                            try context.save()
                        }
                    } catch {
//                        performError = error
                        return nil
                    }
                    // Reset the taskContext to free the cache and lower the memory footprint.
//                    taskContext.reset()
                }
                return rune
            }
        } catch let error {
            return nil
        }
    }
    
    func setStat(_ stat: RuneStatType, value: Int64) {
        switch stat {
        case .hpFlat:
            self.hpFlat = Int32(value)
        case .hpPct:
            self.hpPct = Int16(value)
        case .atkFlat:
            self.atkFlat = Int16(value)
        case .atkPct:
            self.atkPct = Int16(value)
        case .defFlat:
            self.defFlat = Int16(value)
        case .defPct:
            self.defPct = Int16(value)
        case .speed:
            self.speed = Int16(value)
        case .critRatePct:
            self.critRate = Int16(value)
        case .critDmgPct:
            self.critDmg = Int16(value)
        case .resistPct:
            self.resistance = Int16(value)
        case .accuracyPct:
            self.accuracy = Int16(value)
        }
    }


    func getSummonerRunes(context: NSManagedObjectContext, summonerId: Int64) -> NSSet? {
        
        if let summoner = Summoner.findById(summonerId, context: context) {
            return summoner.runes
        } else {
            return []
        }
//            let request : NSFetchRequest<RuneInstance> = RuneInstance.fetchRequest()
//            let predicate = NSPredicate(format: "summonerId = @i", summoner.id)
//
//            request.predicate = predicate
//
//            do {
//                let summoners = try context.fetch(request)
//
//                if summoners.count > 0 {
//                    return [] // FIXME
//// FIXME:                    return summoners.first.runes
//                } else {
//                    if let properties = summonerData {
//                        let summoner = Summoner(summonerData: properties)
//                        return summoner.runes
//                    }
//                }
//        } catch let err as NSError {
//            print("Could not fetch \(err), \(err.userInfo)")
//        }
//
//        }
//        return []
    }
    
    var rType: RuneType {
        // To get a State enum from stateValue, initialize the
        // State type from the Int32 value stateValue
        get {
            return RuneType(rawValue: self.runeType)!
        }

        // newValue will be of type State, thus rawValue will
        // be an Int32 value that can be saved in Core Data
        set {
            self.runeType = newValue.rawValue
        }
    }

    
    var runeTypeName: String {
        return rType.description
    }
    
    var awakening: Awakening {
        switch level {
        case 15:
            return .awakened
        default:
            return .unawakened
        }
    }

    static func findById(_ runeInstanceId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> RuneInstance? {
        
        let request : NSFetchRequest<RuneInstance> = RuneInstance.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", runeInstanceId)
        
        if let results = try? context.fetch(request) {
        
            if let runeInstance = results.first {
                return runeInstance
            }
        }
        return nil
    }
    
    
    /*
     id = rune.fields.rune_id.int
     summonerId = rune.fields.wizard_id.int
     occupiedType = rune.fields.occupied_type.int
     monsterInstanceId = rune.fields.occupied_id.int
     slot = rune.fields.slot_no.int
     rank = rune.fields.rank.int
     runeClass = rune.fields.rune_class.int
     setId = rune.fields.set_id.int
     upgradeLimit = rune.fields.upgrade_limit.int
     upgradeCurr = rune.fields.upgrade_curr.int
     baseValue = rune.fields.base_value.int
     sellValue = rune.fields.sell_value.int
     originalQuality = rune.fields.extra.int // original rune quality

     var jsonArr = rune.fields.priEff.value
     var converted = try! JSON(string: jsonArr as! String).array
     priEff = converted.map {try! JSON(string: $0.value as! String).int}
     print("priEff: \(priEff)")

     */
    
    func unsetValue(forKey: Int) {
        
    }
    // https://www.youtube.com/watch?v=SBWeptNNbYc
    func calcEfficiency() {
        
    }
//    func update<T: JsonArray>(from: T,
//                docInfo: SummonerDocumentInfo) {
//        
//        let runeInstanceData = from as! RuneInstanceData
//        var hasStats = HasRuneStat()
//
//        // don't dirty the record if you don't have to
//        
//        if self.id != runeInstanceData.id {
//            self.id = runeInstanceData.id
//        }
//        if self.summonerId != runeInstanceData.summonerId {
//            self.summonerId = runeInstanceData.summonerId
//            
//            self.summoner = Summoner.findById(self.summonerId, context: docInfo.taskContext)
//        }
//        
//        // it appears occupiedType is 1 if the rune is on a monster and 2 if it's not
//        // if so, not worth storing (it's not in swarfarm)
////        if self.occupiedType != runeInstanceData.occupiedType {
////            self.occupiedType = runeInstanceData.occupiedType
////        }
//
//        if let assignedMonster = runeInstanceData.monsterInstanceId {
//            if self.assignedToId != NSNumber(value: assignedMonster) {
//                self.assignedToId = NSNumber(value: assignedMonster)
//                self.monster = MonsterInstance.findById(assignedMonster, context: docInfo.taskContext)
//            }
//        } else {
//            // maybe was assigned before, but isn't now?
//            if self.assignedToId != nil {
//                self.assignedToId = nil
//            }
//        }
//        
////        if self.assignedToId != runeInstanceData.monsterInstanceId {
////            self.assignedToId = runeInstanceData.monsterInstanceId
////
////            self.monster = MonsterInstance.findById(self.assignedToId, context: docInfo.taskContext)
////        }
//        if self.slot != runeInstanceData.slot {
//            self.slot = runeInstanceData.slot
//        }
//        if self.runeType != runeInstanceData.runeClass {
//            self.runeType = runeInstanceData.runeClass
//        }
//        if self.quality != runeInstanceData.rank {
//            self.quality = runeInstanceData.rank
//        }
//        
//        let stars = runeInstanceData.runeClass
//        if self.stars != stars % 10 {
//            self.stars = stars % 10
//            self.ancient = stars > 10 ? true : false
//        }
//        
//        if self.slot != runeInstanceData.slot {
//            self.slot = runeInstanceData.slot
//        }
//        if self.runeType != runeInstanceData.setId {
//            self.runeType = runeInstanceData.setId
//        }
//        if self.level != runeInstanceData.upgradeCurr {
//            self.level = runeInstanceData.upgradeCurr
//        }
//        if self.runeValue != runeInstanceData.sellValue {
//            self.runeValue = runeInstanceData.sellValue
//        }
//        if self.originalQuality != runeInstanceData.originalQuality % 10 {
//            self.originalQuality = runeInstanceData.originalQuality % 10
//        }
//        
//        if self.mainStat != runeInstanceData.priEff[0] ||
//                self.mainStatValue != runeInstanceData.priEff[1] {
//            self.mainStat = runeInstanceData.priEff[0]
//            self.mainStatValue = runeInstanceData.priEff[1]
//        }
//        if let tempStat = RuneStatType(rawValue: self.mainStat) {
//            hasStats.setFlag(tempStat)
//            self.setStat(tempStat, value: self.mainStatValue)
//        }
//        // while not all runes have innate stats, the data file does
//        // have zeroes in place, so it's not conditional
//        if self.innateStat != runeInstanceData.prefixEff[0] ||
//                self.innateStatValue != runeInstanceData.prefixEff[1] {
//            self.innateStat = runeInstanceData.prefixEff[0]
//            self.innateStatValue = runeInstanceData.prefixEff[1]
//        }
//        if let stat = RuneStatType(rawValue: self.innateStat) {
//            hasStats.setFlag(stat)
//            self.setStat(stat, value: self.innateStatValue)
//        }
//
//        // for normal (lowest value) runes, no stats have yet been revealed,
//        // but that means the array is empty, not optional
//
//        let statCount = runeInstanceData.secEff.count
//        if statCount > 0 {
//            let substat = runeInstanceData.secEff[0]
//            
//            self.substat1 = substat[0]
//            self.substat1Value = substat[1]
//            self.substat1Enchanted = substat[2] == 1
//            self.substat1Craft = substat[3]
//            if let stat = RuneStatType(rawValue: substat[0]) {
//                hasStats.setFlag(stat)
//                self.setStat(stat, value: self.substat1Value)
//            }
//        }
//        if statCount > 1 {
//            let substat = runeInstanceData.secEff[1]
//            self.substat2 = substat[0]
//            self.substat2Value = substat[1]
//            self.substat2Enchanted = substat[2] == 1
//            self.substat2Craft = substat[3]
//            if let stat = RuneStatType(rawValue: substat[0]) {
//                hasStats.setFlag(stat)
//                self.setStat(stat, value: self.substat2Value)
//            }
//        }
//        if statCount > 2 {
//            let substat = runeInstanceData.secEff[2]
//            self.substat3 = substat[0]
//            self.substat3Value = substat[1]
//            self.substat3Enchanted = substat[2] == 1
//            self.substat3Craft = substat[3]
//            if let stat = RuneStatType(rawValue: substat[0]) {
//                hasStats.setFlag(stat)
//                self.setStat(stat, value: self.substat3Value)
//            }
//        }
//        if statCount > 3 {
//            let substat = runeInstanceData.secEff[3]
//            self.substat4 = substat[0]
//            self.substat4Value = substat[1]
//            self.substat4Enchanted = substat[2] == 1
//            self.substat4Craft = substat[3]
//            if let stat = RuneStatType(rawValue: substat[0]) {
//                hasStats.setFlag(stat)
//                self.setStat(stat, value: self.substat4Value)
//            }
//        }
//        if self.hasHP != hasStats.hasHp {
//            self.hasHP = hasStats.hasHp
//        }
//        if self.hasAtk != hasStats.hasAtk {
//            self.hasAtk = hasStats.hasAtk
//        }
//        if self.hasDef != hasStats.hasDef {
//            self.hasDef = hasStats.hasDef
//        }
//        if self.hasSpeed != hasStats.hasSpeed {
//            self.hasSpeed = hasStats.hasSpeed
//        }
//        if self.hasCritRate != hasStats.hasCritRate {
//            self.hasCritRate = hasStats.hasCritRate
//        }
//        if self.hasCritDmg != hasStats.hasCritDmg {
//            self.hasCritDmg = hasStats.hasCritDmg
//        }
//        if self.hasResist != hasStats.hasResist {
//            self.hasResist = hasStats.hasResist
//        }
//        if self.hasAccuracy != hasStats.hasAcc {
//            self.hasAccuracy = hasStats.hasAcc
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        docInfo.taskContext.performAndWait {
//            let runeInstanceData = from as! RuneInstanceData
//            let runeInstance = RuneInstance.findById(runeInstanceData.id, context: docInfo.taskContext) ?? RuneInstance(context: docInfo.taskContext)
//            runeInstance.update(from: runeInstanceData, docInfo: docInfo)
//        }
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let runes = from as! [RuneInstanceData]
//        for rune in runes {
////            print(rune)
//            RuneInstance.insertOrUpdate(from: rune, docInfo: docInfo)
//        }
//    }

    static func findSummonerRunes(docInfo: SummonerDocumentInfo) -> [RuneInstance] {

        let request : NSFetchRequest<RuneInstance> = RuneInstance.fetchRequest()

        request.predicate = NSPredicate(format: "summonerId = %i", docInfo.summonerId)

        if let results = try? docInfo.taskContext.fetch(request) {

            return results
        }
        return []
    }
 }

public struct RuneStarsView: View {
    let awakening: Awakening
    let rune: RuneType
    let numStars: Int64
    let level: Int64
    
    public var body: some View {
//    static func showStars(numStars: Int, awakening: Awakening) -> some View {
        let range = Range(1...Int(numStars))
        LazyHStack(
            alignment: .top,
            spacing: 1
        ) {
            Spacer()
            ForEach(range) { _ in
                Image(decorative: ImageStore.loadImage(type: ImageType.stars, name: "star-\(awakening.rawValue).png"),
                    scale: 3,
                    orientation: .up
                )
            }
            Spacer()
        }
        .padding(.zero)

    }
}

// MARK: - Original SQL Table Definition

/*
 "runes": [
 {
   "rune_id": 123456,
   "wizard_id": 6789,
   "occupied_type": 2,
   "occupied_id": 0,
   "slot_no": 1,
   "rank": 3,
   "class": 6,
   "set_id": 1,
   "upgrade_limit": 15,
   "upgrade_curr": 6,
   "base_value": 240920,
   "sell_value": 18012,
   "pri_eff": [
     3,
     70
   ],
   "prefix_eff": [
     1,
     167
   ],
   "sec_eff": [
     [
       8,
       10,
       0,
       0
     ],
     [
       9,
       9,
       0,
       0
     ]
   ],
   "extra": 3
 },
 {
   "rune_id": 123457,
   "wizard_id": 6789,
   "occupied_type": 2,
   "occupied_id": 0,
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
     6,
     7
   ],
   "sec_eff": [
     [
       11,
       17,
       0,
       0
     ],
     [
       5,
       14,
       0,
       0
     ],
     [
       10,
       6,
       0,
       0
     ],
     [
       2,
       6,
       0,
       0
     ]
   ],
   "extra": 3
 },
*/


/*
    CREATE TABLE public.herders_runeinstance
    (
     id uuid NOT NULL,
     type integer NOT NULL,
     com2us_id bigint,
     marked_for_sale boolean NOT NULL,
     notes text COLLATE pg_catalog."default",
     stars integer NOT NULL,
     level integer NOT NULL,
     slot integer NOT NULL,
     original_quality integer,
     value integer,
     main_stat integer NOT NULL,
     main_stat_value integer NOT NULL,
     innate_stat integer,
     innate_stat_value integer,
     substats integer[] NOT NULL,
     substat_values integer[] NOT NULL,
     substat_1 integer,
     substat_1_value integer,
     substat_1_craft integer,
     substat_2 integer,
     substat_2_value integer,
     substat_2_craft integer,
     substat_3 integer,
     substat_3_value integer,
     substat_3_craft integer,
     substat_4 integer,
     substat_4_value integer,
     substat_4_craft integer,
     quality integer NOT NULL,
     has_hp boolean NOT NULL,
     has_atk boolean NOT NULL,
     has_def boolean NOT NULL,
     has_crit_rate boolean NOT NULL,
     has_crit_dmg boolean NOT NULL,
     has_speed boolean NOT NULL,
     has_resist boolean NOT NULL,
     has_accuracy boolean NOT NULL,
     substat_upgrades_remaining integer,
     efficiency double precision,
     max_efficiency double precision,
     assigned_to_id uuid,
     owner_id integer NOT NULL,
     ancient boolean NOT NULL,
     substats_enchanted boolean[] NOT NULL,
     substats_grind_value integer[] NOT NULL,
     has_gem boolean NOT NULL,
     has_grind integer NOT NULL,
     CONSTRAINT herders_runeinstance_pkey PRIMARY KEY (id),
     CONSTRAINT herders_runeinstance_assigned_to_id_bbb93e36_fk_herders_m FOREIGN KEY (assigned_to_id)
         REFERENCES public.herders_monsterinstance (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_runeinstance_owner_id_f22228d1_fk_herders_summoner_id FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
