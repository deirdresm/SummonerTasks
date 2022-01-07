//
//  Monster+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/29/20.
//

import Foundation
import CoreData

extension Monster {
    public static var lightSlayer: Monster {
        let monster = Monster(context: Persistence.shared.container.viewContext)
        monster.name = "Craig"
        monster.imageFilename = "unit_icon_0068_1_4.png"
        monster.id = 24714
        monster.familyId = 24700
        monster.element = "light"
        monster.archetype = "hp"
        monster.naturalStars = 5
        monster.baseStars = 6
        monster.isAwakened = true
        monster.awakenLevel = 1
        
        return monster
    }

    public static var darkSlayer: Monster {
        let monster = Monster(context: Persistence.shared.container.viewContext)
        monster.name = "Gurkha"
        monster.imageFilename = "unit_icon_0068_1_5.png"
        monster.id = 24715
        monster.familyId = 24700
        monster.element = "dark"
        monster.archetype = "hp"
        monster.naturalStars = 5
        monster.baseStars = 6
        monster.isAwakened = true
        monster.awakenLevel = 1

        return monster
    }

    public static var baleygr: Monster {
        let monster = Monster(context: Persistence.shared.container.viewContext)
        monster.name = "Baleygr"
        monster.imageFilename = "unit_icon_0047_1_2.png"
        monster.id = 22612
        monster.familyId = 22600
        monster.element = "fire"
        monster.archetype = "attack"
        monster.naturalStars = 5
        monster.baseStars = 6
        monster.isAwakened = true
        monster.awakenLevel = 1
        monster.leaderSkillId = 183
        monster.maxLvlHp = 9720
        monster.maxLvlAttack = 703
        monster.maxLvlDefense = 626
        monster.speed = 101
        monster.critRate = 15
        monster.critDamage = 50
        monster.resistance = 15
        monster.accuracy = 0
        monster.skillUpsToMax = 11
        
        monster.awakenMatsFireLow = 0
        monster.awakenMatsFireMid = 10
        monster.awakenMatsFireHigh = 20
        monster.awakenMatsMagicLow = 0
        monster.awakenMatsMagicMid = 5
        monster.awakenMatsMagicHigh = 15

        monster.leaderSkill = LeaderSkill.baleygrLeader
        monster.source = [Source.fusion]
        monster.skillArray = [2083, 2088, 2093]
        
        return monster
    }
}
