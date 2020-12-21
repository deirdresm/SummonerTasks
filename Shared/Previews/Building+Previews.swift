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
        let building = Building(context: PersistenceController.shared.container.viewContext)
        building.id = 14
        building.com2usId = 9
        building.name = "Ancient Sword"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 1
        building.imageFilename = "ancient_sword"
        building.element = nil
        building.statBonus = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
        building.upgradeCost = [150, 375, 600, 825, 1050, 1275, 1500, 1725, 1950, 2175]

        return building
    }

    public static var darkSanctuary: Building {
        let building = Building(context: PersistenceController.shared.container.viewContext)
        building.id = 6
        building.com2usId = 19
        building.name = "Dark Sanctuary"
        building.maxLevel = 10
        building.area = 0
        building.affectedStat = 1
        building.imageFilename = "dark_sanctuary"
        building.element = "dark"
        building.statBonus = [3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
        building.upgradeCost = [120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200]

        return building
    }

}
