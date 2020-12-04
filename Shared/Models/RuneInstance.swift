//
//  RuneInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data

// MARK: - JSON

// MARK: - Original SQL Table Definition

extension RuneInstance {
    
//    static func makePreviewRune() -> RuneInstance {
//        
//        
//    }
    
}

// com2us mapping of rune values

enum RuneType: Int {
    case energy = 1, guardRune, swift, blade, rage, focus, endure, fatal
    case despair = 10, vampire, violent = 13, nemesis, will, shield, revenge
    case destroy, fight, determination, enhance, accuracy, tolerance // tolerance = 23
    
    var numInSet: Int {
        switch self {
        case .swift, .rage, .fatal, .despair, .vampire, .violent:
            return 4
        default:
            return 2
        }
    }
}

struct RuneStat: Decodable {
    let stat: Int?
    let statValue: Int?
}

struct RuneSubstat: Decodable {
    let stat: Int?
    let statValue: Int?
    let grind: Int?
    let enchanted: Int?
}


struct RuneProperties: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case runeId
        case wizardId
        case occupiedType
        case occupiedId
        case slotNo
        case rank
        case runeClass = "class"
        case setId
        case upgradeLimit
        case upgradeCurr
        case baseValue
        case sellValue
        case mainStat = "pri_eff"
        case innateStat = "prefix_eff"
        case substats = "sec_eff"
        case originalQuality = "extra"
    }
    
    let runeId:             Int?
    let wizardId:           Int?
    let occupiedType:       Int? // note: this is for all but RTA
    let occupiedId:         Int? // note: this is for all but RTA
    let slotNo:             Int?
    let rank:               Int?
    let runeClass:          Int?
    let setId:              Int?
    let upgradeLimit:       Int?
    let upgradeCurr:        Int?
    let baseValue:          Int?
    let sellValue:          Int?
    let mainStat:           RuneStat?
    let innateStat:         RuneStat?
    var substats:           [RuneSubstat]?
    let originalQuality:    Int?
    
}

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
