//
//  BuildingEnums.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/21/21.
//

import Foundation

enum BuildingFilter {
        case none, battle, elemental, guild, arena
}

enum BuildingType: Int64 {
    case summonerTower, summonhenge, pondOfMana, crystalMine, gateway = 8,
        templeOfWishes = 10, magicShop, ancientStones, arcaneTower = 14,
        crystalTitan, fusionHexagram, fuseCenter, powerUpCircle = 20,
        tranquilForest = 22, gustyCliffs, deepForestEnt, monsterStorage,
        transmogrificationBuilding = 27
}

enum BattleBuilding: Int64 {
    case guardstone = 4, manaFountain, skyTribeTotem, arcaneBoosterTower,
        crystalAltar, ancientSword, sanctumOfEnergy, mysteriousPlant,
        fireSanctuary = 15, waterSanctuary, windSanctuary, lightSanctuary,
        darkSanctuary, fallenAncientKeeper = 31, crystalRock = 34, fairyTree,
        flagOfBattle, flagOfRage, flagOfHope, flagOfWill

    // in same order as on profile: hp, atk, def, speed, cd
    static func battleBuildings() -> [BattleBuilding] {
        return([.crystalAltar, .ancientSword, .guardstone, .skyTribeTotem, .fallenAncientKeeper])
    }

    // in same order as usually given: fire, water, wind, light, dark
    static func elementalBuildings() -> [BattleBuilding] {
        return([.fireSanctuary, .waterSanctuary, .windSanctuary, .lightSanctuary, .darkSanctuary])
    }

    // in same order as on profile: hp, atk, def, cd
    static func guildBuildings() -> [BattleBuilding] {
        return([.flagOfHope, .flagOfBattle, .flagOfWill, .flagOfRage])
    }

    // in shop order
    static func arenaBuildings() -> [BattleBuilding] {
        return([.crystalRock, .arcaneBoosterTower])
    }
}

