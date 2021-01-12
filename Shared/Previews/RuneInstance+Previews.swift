//
//  RuneInstance+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/20.
//

import Foundation
import CoreData


// MARK: - Preview Data

extension RuneInstance {
    public static var swiftSpeed: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456782
        rune.runeType = RuneType.swift.rawValue
        rune.stars = 6
        rune.level = 15
        rune.slot = 2
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.speed.intValue()
        rune.mainStatValue = 42
        rune.hasSpeed = true

        return rune
    }
    public static var swiftSlot1: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456781
        rune.runeType = RuneType.swift.rawValue
        rune.stars = 6
        rune.level = 14
        rune.slot = 1
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.atkFlat.intValue()
        rune.mainStatValue = 128
        rune.hasAtk = true

        return rune
    }
    
    public static var swiftSlot3: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456783
        rune.runeType = RuneType.swift.rawValue
        rune.stars = 6
        rune.level = 15
        rune.slot = 3
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.defFlat.intValue()
        rune.mainStatValue = 160
        rune.hasDef = true

        return rune
    }
    public static var focusSlot5: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456785
        rune.runeType = RuneType.focus.rawValue
        rune.stars = 6
        rune.level = 15
        rune.slot = 5
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.hpFlat.intValue()
        rune.mainStatValue = 2448
        rune.hasHP = true

        return rune
    }
    
    public static var swiftSlot4: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456784
        rune.runeType = RuneType.swift.rawValue
        rune.stars = 6
        rune.level = 15
        rune.slot = 4
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.hpPct.intValue()
        rune.mainStatValue = 63
        rune.hasHP = true

        return rune
    }
    public static var focusSlot6: RuneInstance {
        let rune = RuneInstance(context: PersistenceController.shared.container.viewContext)
        rune.id = 123456786
        rune.runeType = RuneType.focus.rawValue
        rune.stars = 6
        rune.level = 14
        rune.slot = 6
        rune.quality = RuneQuality.legend.intValue()
        rune.originalQuality = RuneQuality.rare.intValue()
        rune.mainStat = RuneStatType.hpPct.intValue()
        rune.mainStatValue = 63
        rune.hasHP = true

        return rune
    }
    
    public static var sampleRunes: [RuneInstance] = {
        return [RuneInstance.swiftSpeed, RuneInstance.swiftSlot1, RuneInstance.swiftSlot3, RuneInstance.focusSlot5,
            RuneInstance.swiftSlot4, RuneInstance.focusSlot6]
    }()
}
    
/* CREATE TABLE public.herders_runeinstance
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

*/
