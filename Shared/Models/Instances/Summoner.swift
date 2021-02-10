//
//  Summoner.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData
import Cocoa

// MARK: - Core Data

extension Summoner: CoreDataUtilityMutable {
    static let classNameTransformerName = NSValueTransformerName(rawValue: "JSONValueTransformer")
    
    static func findById(_ summonerId: Int64,
                                 context: NSManagedObjectContext)
    -> Summoner? {
        
        let request : NSFetchRequest<Summoner> = Summoner.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", summonerId)
        
        if let results = try? context.fetch(request) {
        
            if let summoner = results.first {
                return summoner
            }
        }
        return nil
    }
    
    func update<T: JsonArrayMutable>(from: T, docInfo: inout SummonerDocumentInfo) {
        let summonerData = from as! SummonerData
        
        // don't dirty the record if you don't have to
        
        if self.name != summonerData.name {
            self.name = summonerData.name
        }
        if self.id != summonerData.id {
            self.id = summonerData.id
        }
        if self.lastUpdate != summonerData.lastUpdate {
            self.lastUpdate = summonerData.lastUpdate
        }
//        if self.server != summonerData.server {
//            self.server = summonerData.server
//        }
        if self.timezone != summonerData.timezone {
            self.timezone = summonerData.timezone
        }
    }
    
    static func insertOrUpdate<T: JsonArrayMutable>(from: T,
                               docInfo: inout SummonerDocumentInfo) {
        let summonerData = from as! SummonerData
        let summoner: Summoner = Summoner.findById(summonerData.id, context: docInfo.taskContext) ??
            Summoner(context: docInfo.taskContext)
        
        summoner.update(from: summonerData, docInfo: &docInfo)
        docInfo.summoner = summoner
        docInfo.summonerSet = true
        docInfo.summonerId = summoner.id
    }
    
    static func batchUpdate<T: JsonArrayMutable>(from: [T],
                            docInfo: inout SummonerDocumentInfo) {
        let summoners = from as! [SummonerData]
        let summoner = summoners.first!
        Summoner.insertOrUpdate(from: summoner, docInfo: &docInfo)
    }
    
    // TODO: we need a big sort thing, so this is a temp stopgap
    func runesSorted() -> [RuneInstance] {
        let slotSort = NSSortDescriptor.init(key: "slot", ascending: true)
        let typeSort = NSSortDescriptor.init(key: "runeType", ascending: true)
        let valueSort = NSSortDescriptor.init(key: "runeValue", ascending: false)

        return (self.runes)?.sortedArray(using: [slotSort, typeSort, valueSort]) as! [RuneInstance]
    }
    
    func setBuildingStat(_ building: BuildingInstance) {
        guard let buildingType = BattleBuilding(rawValue: building.buildingId) else {
            return
        }
        
        switch buildingType {
        case .crystalAltar:
            self.bonusHp = building.getBuildingBonus()
        case .ancientSword:
            self.bonusAtk = building.getBuildingBonus()
        case .guardstone:
            self.bonusDef = building.getBuildingBonus()
        case .skyTribeTotem:
            self.bonusSpd = building.getBuildingBonus()
        case .fallenAncientKeeper:
            self.bonusCritDmg = building.getBuildingBonus()
        case .fireSanctuary:
            self.bonusFire = building.getBuildingBonus()
        case .waterSanctuary:
            self.bonusWater = building.getBuildingBonus()
        case .windSanctuary:
            self.bonusWind = building.getBuildingBonus()
        case .lightSanctuary:
            self.bonusLight = building.getBuildingBonus()
        case .darkSanctuary:
            self.bonusDark = building.getBuildingBonus()
        case .flagOfHope:
            self.guildHp = building.getBuildingBonus()
        case .flagOfBattle:
            self.guildAtk = building.getBuildingBonus()
        case .flagOfWill:
            self.guildDef = building.getBuildingBonus()
        case .flagOfRage:
            self.guildCritDmg = building.getBuildingBonus()
        default:
            break
        }
    }

}

@objc(JSONValueTransformer)
public final class JSONValueTransformer: ValueTransformer {
    override public class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override public func transformedValue(_ value: Any?) -> Any? {
        return (value as! NSColor).className //TODO: fix to JSON
    }
}


/*
 "wizard_info": {
   "wizard_id": 1234567,
   "wizard_name": "namegoeshere",
   "wizard_mana": 417401,
   "wizard_crystal": 4423,
   "wizard_crystal_paid": 4322,
   "wizard_last_login": "2020-09-23 04:43:55",
   "wizard_last_country": "US",
   "wizard_last_lang": "en",
   "wizard_level": 50,
   "experience": 3800000,
   "wizard_energy": 162,
   "energy_max": 200,
   "energy_per_min": 0.26,
   "next_energy_gain": 176,
   "arena_energy": 6,
   "arena_energy_max": 10,
   "arena_energy_next_gain": 1265,
   "unit_slots": {
     "number": 120
   },
*/



// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.herders_summoner
    (
     id integer NOT NULL DEFAULT nextval('herders_summoner_id_seq'::regclass),
     summoner_name character varying(256) COLLATE pg_catalog."default",
     com2us_id bigint,
     server integer,
     public boolean NOT NULL,
     timezone character varying(63) COLLATE pg_catalog."default" NOT NULL,
     notes text COLLATE pg_catalog."default",
     preferences jsonb NOT NULL,
     last_update timestamp with time zone NOT NULL,
     user_id integer NOT NULL,
     CONSTRAINT herders_summoner_pkey PRIMARY KEY (id),
     CONSTRAINT herders_summoner_user_id_key UNIQUE (user_id),
     CONSTRAINT herders_summoner_user_id_aacda62d_fk_auth_user_id FOREIGN KEY (user_id)
         REFERENCES public.auth_user (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
    WITH (
     OIDS = FALSE
    )
*/
