//
//  MonsterEnums.swift
//  SummonerTasks (iOS)
//
//  Created by Deirdre Saoirse Moen on 12/22/20.
//

import Foundation

// MARK: - Enums

enum Archetype: Int64 {
    case none = 0, attack, defense, hp, support, material
}

enum Awakening: String {
    case awakened
    case awakened2
    case fodder
    case incomplete
    case unawakened
}

