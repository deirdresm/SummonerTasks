//
//  Summoner.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData
import Cocoa

enum TimezoneServerMap: String, CaseIterable {
    case global = "America/Los_Angeles"
    case europe = "Europe/Berlin"
    case korea = "Asia/Seoul"
    case asia = "Asia/Shanghai"
    case japan
    case china

    func server() -> Int16 {
        switch self {
        case .global:
            return 0
        case .europe:
            return 1
        case .korea:
            return 2
        case .asia:
            return 3
        case .japan:
            return 4
        case .china:
            return 5
        }
    }
}

// MARK: - Core Data

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


@objc(Summoner)
public class Summoner: NSManagedObject, Decodable {
//    static let classNameTransformerName = NSValueTransformerName(rawValue: "JSONValueTransformer")

    private enum CodingKeys: String, CodingKey {
        case id = "wizard_id"
        case name = "wizard_name"
        case lastUpdate = "wizard_last_login"
//        case server = "tzone" // not in wizard_id structure, at top level
//        case timezone = "timezone" // not in wizard_id structure, derived
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for Summoner]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Summoner", in: context) else { fatalError("Could not get entity [for Summoner]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)

        let rawDate = try container.decode(String.self, forKey: .lastUpdate)
        let formatter = DateFormatter.com2us
        self.lastUpdate = formatter.date(from: rawDate)

//        let tz = try container.decode(String.self, forKey: .server)
//        self.timezone = tz
//        if let serverMap = TimezoneServerMap.from(string: tz)?.server() {
//            self.server = serverMap
//        }
    }

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

    public static func == (lhs: Summoner, rhs: Summoner) -> Bool {
        return lhs.id == rhs.id
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
