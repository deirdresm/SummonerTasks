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

enum Element: Int64, CaseIterable {
    case water = 1, fire, wind, light, dark, pure
    
    static var magic: Element {
        get {
            return self.pure
        }
    }
    
    // return the text value of the label, lowercase
    var description: String {
        return "\(self)"
    }
    
    // return the text value of the label, but initial cap
    static func imageTitleFrag(_ element: Int64) -> String? {
        switch Element(rawValue: element) {
        case .water, .fire, .wind, .light, .dark:
            return ("\(self)").firstCapitalized // "Water"
        default:
            return nil
        }
    }
    
    // instance version of above
    public func imageTitleFrag() -> String? {
        switch self {
        case .water, .fire, .wind, .light, .dark:
            return ("\(self)").firstCapitalized // "Water"
        default:
            return nil
        }
    }
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
