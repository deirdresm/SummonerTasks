//
//  Building+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/10/20.
//

import Foundation
import CoreData

// MARK: - Preview Data

extension Building {
    
    public static var ancientSword: Building {
        let building = Building(context: Persistence.shared.container.viewContext)
        building.id = 14
        building.com2usId = 9
        building.name = "Ancient Sword"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 1
        building.imageFilename = "ancient_sword.png"
        building.element = nil
        building.statBonus = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        building.upgradeCost = [150, 375, 600, 825, 1050, 1275, 1500, 1725, 1950, 2175]

        return building
    }

    public static var skyTribeTotem: Building {
        let building = Building(context: Persistence.shared.container.viewContext)
        building.id = 8
        building.com2usId = 6
        building.name = "Sky Tribe Totem"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 3
        building.imageFilename = "sky_tribe_totem.png"
        building.element = nil
        building.statBonus = [2, 3, 5, 6, 8, 9, 11, 12, 14, 15]
        building.upgradeCost = [240, 440, 650, 840, 1040, 1240, 1440, 1640, 1840, 2040]

        return building
    }

    public static var fallenAncientGuardian: Building {
        let building = Building(context: Persistence.shared.container.viewContext)
        building.id = 7
        building.com2usId = 31
        building.name = "Fallen Ancient Guardian"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 5
        building.imageFilename = "fallen_ancient_guardian.png"
        building.element = nil
        building.statBonus = [2, 5, 7, 10, 12, 15, 17, 20, 22, 25]
        building.upgradeCost = [120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200]

        return building
    }

    public static var darkSanctuary: Building {
        let building = Building(context: Persistence.shared.container.viewContext)
        building.id = 6
        building.com2usId = 19
        building.name = "Dark Sanctuary"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 1
        building.imageFilename = "dark_sanctuary.png"
        building.element = "dark"
        building.statBonus = [3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
        building.upgradeCost = [120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200]

        return building
    }
}
