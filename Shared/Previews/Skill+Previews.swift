//
//  Building+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/30/20.
//

import Foundation
import CoreData

// MARK: - Preview Data

extension Skill {
    
    /*
     {
       "model": "bestiary.skill",
       "pk": 2083,
       "fields": {
         "com2us_id": 13102,
         "name": "Lightning Strike",
         "description": "Attacks the enemy and steals one beneficial effect with a 50% chance.",
         "slot": 1,
         "cooltime": null,
         "hits": 1,
         "aoe": false,
         "passive": false,
         "max_level": 9,
         "icon_filename": "skill_icon_0017_9_7.png",
         "multiplier_formula": "3.7*{ATK}",
         "multiplier_formula_raw": "[[\"ATK\", \"*\", 3.7]]",
         "level_progress_description": "Damage +5%\nDamage +5%\nEffect Rate +10%\nEffect Rate +10%\nDamage +10%\nDamage +10%\nEffect Rate +15%\nEffect Rate +15%",
         "skill_effect": [
           42
         ],
         "scaling_stats": [
           10
         ]
       }
     },
     {
       "model": "bestiary.skill",
       "pk": 2088,
       "fields": {
         "com2us_id": 13107,
         "name": "Gain Knowledge (Passive)",
         "description": "Gains Knowledge by the number of granted beneficial effects when you're granted with a beneficial effect. Gains 3 Knowledge when an enemy or an ally gets defeated. You can have up to 5 Knowledge. [Automatic Effect]",
         "slot": 2,
         "cooltime": null,
         "hits": 1,
         "aoe": false,
         "passive": true,
         "max_level": 1,
         "icon_filename": "skill_icon_0017_4_8.png",
         "multiplier_formula": "",
         "multiplier_formula_raw": "[]",
         "level_progress_description": "",
         "skill_effect": [
           70
         ],
         "scaling_stats": [

         ]
       }
     },
     {
       "model": "bestiary.skill",
       "pk": 2093,
       "fields": {
         "com2us_id": 13112,
         "name": "Start of Apocalypse",
         "description": "Attacks the enemies in the order of low HP ratio to high HP ratio by the number of Knowledge you have, and the damage increases as you attack. If you have 5 Knowledge, destroys the enemy's MAX HP by 50% of the damage dealt. This skill can be used when you have at least 1 Knowledge, and all Knowledge will be consumed once you use the skill.",
         "slot": 3,
         "cooltime": null,
         "hits": 5,
         "aoe": true,
         "passive": false,
         "max_level": 4,
         "icon_filename": "skill_icon_0017_9_8.png",
         "multiplier_formula": "4.0*{ATK}",
         "multiplier_formula_raw": "[[\"ATK\", \"*\", 4.0]]",
         "level_progress_description": "Damage +5%\nDamage +10%\nDamage +15%",
         "skill_effect": [
           57,
           72
         ],
         "scaling_stats": [
           10
         ]
       }
     },

     */
    
    public static var baleygr1: Skill {
        let skill = Skill(context: Persistence.shared.container.viewContext)
        skill.id = 2083
        skill.slot = 1
        skill.name = "Lightning Strike"
        skill.maxLevel = 9
        skill.c2uDescription = "Attacks the enemy and steals one beneficial effect with a 50% chance."
        skill.imageFilename = "skill_icon_0017_9_7.png"
        skill.aoe = false
        skill.passive = false
        skill.levelProgressDescription = "Damage +5%\nDamage +5%\nEffect Rate +10%\nEffect Rate +10%\nDamage +10%\nDamage +10%\nEffect Rate +15%\nEffect Rate +15%"
        skill.hits = 1
        skill.skillEffect = [42]
        skill.scalingStatsIds = [10]

        return skill
    }

    public static var baleygr2: Skill {
        let skill = Skill(context: Persistence.shared.container.viewContext)
        skill.id = 2088
        skill.slot = 2
        skill.name = "Gain Knowledge (Passive)"
        skill.maxLevel = 1
        skill.c2uDescription = "Gains Knowledge by the number of granted beneficial effects when you're granted with a beneficial effect. Gains 3 Knowledge when an enemy or an ally gets defeated. You can have up to 5 Knowledge. [Automatic Effect]"
        skill.imageFilename = "skill_icon_0017_4_8.png"
        skill.aoe = false
        skill.passive = true
        skill.hits = 1

        return skill
    }


    public static var baleygr3: Skill {
        let skill = Skill(context: Persistence.shared.container.viewContext)
        skill.id = 2093
        skill.slot = 3
        skill.name = "Start of Apocalypse"
        skill.maxLevel = 4
        skill.c2uDescription = "Attacks the enemies in the order of low HP ratio to high HP ratio by the number of Knowledge you have, and the damage increases as you attack. If you have 5 Knowledge, destroys the enemy's MAX HP by 50% of the damage dealt. This skill can be used when you have at least 1 Knowledge, and all Knowledge will be consumed once you use the skill."
        skill.imageFilename = "skill_icon_0017_9_8.png"
        skill.aoe = true
        skill.passive = false
        skill.hits = 5

        return skill
    }

}
