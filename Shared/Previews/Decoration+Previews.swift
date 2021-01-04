//
//  BuildingInstance+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/20.
//

import Foundation
import CoreData

// Note: these are actually called Decorations in the API file.

/*
 "deco_list": [
 {
   "wizard_id": 1234567,
   "deco_id": 20568456,
   "master_id": 31,
   "island_id": 5,
   "pos_x": 16,
   "pos_y": 12,
   "level": 5
 },
*/

extension BuildingInstance {

    public static var skyTribeTotemInstance: BuildingInstance {
        let buildingInstance = BuildingInstance(context: PersistenceController.shared.container.viewContext)
        
        let building = Building.skyTribeTotem
        let summoner = Summoner.tisHerself
        
        buildingInstance.buildingId = 332755950
        buildingInstance.com2usId = building.id
        buildingInstance.level = 5
        buildingInstance.summonerId = summoner.id
        
        buildingInstance.building = building
        buildingInstance.summoner = summoner

        return buildingInstance
    }

   public static var ancientSwordInstance: BuildingInstance {
        let buildingInstance = BuildingInstance(context: PersistenceController.shared.container.viewContext)
        let building = Building.ancientSword
        let summoner = Summoner.tisHerself
        
        buildingInstance.buildingId = 14
        buildingInstance.com2usId = building.id
        buildingInstance.level = 3
        buildingInstance.summonerId = summoner.id

        buildingInstance.building = building
        buildingInstance.summoner = summoner

        return buildingInstance
    }

    public static var darkSanctuaryInstance: BuildingInstance {
        let buildingInstance = BuildingInstance(context: PersistenceController.shared.container.viewContext)
        let building = Building.darkSanctuary
        let summoner = Summoner.tisHerself
        
        buildingInstance.buildingId = 6
        buildingInstance.com2usId = 19
        buildingInstance.level = 3
        buildingInstance.summonerId = summoner.id

        buildingInstance.building = building
        buildingInstance.summoner = summoner

        return buildingInstance
    }
}
