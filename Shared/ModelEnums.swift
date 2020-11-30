//
//  ModelEnums.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 11/16/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// Monster-related enums

enum Element: Int {
    case water = 1, fire, wind, light, dark, pure
    
    static var magic: Element {
        get {
            return self.pure
        }
    }
}

enum Archetype: Int {
    case none = 0, attack, defense, hp, support, material
}

enum LeaderSkillStat: Int {
    case hp = 1, attack, defense, speed, critRate, critDamage, resist, accuracy
}

enum LeaderSkillArea: Int {
    case general = 1, arena, dungeon, guild
}

// Items

enum Building: Int {
    case summonerTower, summohenge, pondOfMana, crystalMine, gateway = 8,
        templeOfWishes = 10, magicShop, ancientStones, arcaneTower = 14,
        crystalTitan, fusionHexagram, fuseCenter, powerUpCircle = 20,
        tranquilForest = 22, gustyCliffs, deepForestEnt, monsterStorage,
        transmogrificationBuilding = 27
}

enum Decoration: Int {
    case guardstone = 4, manaFountain, skyTribeTotem, arcaneBoosterTower,
        crystalAltar, ancientSword, sanctumOfEnergy, mysteriousPlant,
        fireSanctuary = 15, waterSanctuary, windSanctuary, lightSanctuary,
        darkSanctuary, fallenAncientGuardian = 31, crystalRock = 34, fairyTree,
        flagOfBattle, flagOfRage, flagOfHope, flagOfWill
}

enum Inventory: Int {
    case monster, currency = 6, rune = 8, scroll, booster, essence, monsterPiece,
        guildMonsterPiece = 19, rainbowmon = 25, runeCraft = 27, craftStuff = 29
}

enum EssenceLevel: Int {
    case low = 11000, mid = 12000, high = 13000
}

struct Essence: Equatable {
    var element: Element
    var level: EssenceLevel
    
    lazy var apiValue = element.rawValue + level.rawValue
}
