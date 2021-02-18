//
//  ModelEnums.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 11/16/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation

// Monster-related enums

// https://stackoverflow.com/questions/30009788/in-swift-is-it-possible-to-convert-a-string-to-an-enum
extension CaseIterable {
    static func from(string: String) -> Self? {
        return Self.allCases.first { string == "\($0)" }
    }
    func toString() -> String { "\(self)" }
}

// Items

enum Inventory: Int64 {
    case monster, currency = 6, rune = 8, scroll, booster, essence, monsterPiece,
        guildMonsterPiece = 19, rainbowmon = 25, runeCraft = 27, craftStuff = 29
}

enum EssenceLevel: Int64 {
    case low = 11000, mid = 12000, high = 13000
}

struct Essence: Equatable {
    var element: Element
    var level: EssenceLevel
    
    lazy var apiValue = element.rawValue + level.rawValue
}
