//
//  RuneEnums.swift
//  RuneEnums
//
//  Created by Deirdre Saoirse Moen on 9/1/21.
//

import Foundation

// MARK: - Land of Many Enums, Core Data

/// Rune Parameters - things that "don't change" about runes

enum RuneQuality: String {
	case normal
	case magic
	case rare
	case hero
	case legend

	static func fromCom2us(_ rank: Int16) -> RuneQuality {
		switch rank {
		case 1:
			return .normal
		case 2:
			return .magic
		case 3:
			return .rare
		case 4:
			return .hero
		case 5:
			return .legend
		default:
			return .normal
		}
	}

	static func runeLevel(level: Int16) -> RuneQuality {
		switch level {
		case 1...3:
			return .normal
		case 4...6:
			return .magic
		case 7...9:
			return .rare
		case 10...12:
			return .hero
		case 13...15:
			return .legend
		default:
			return .normal
		}
	}

	func intValue() -> Int16 {
		switch self {
		case .normal:
			return 1
		case .magic:
			return 2
		case .rare:
			return 3
		case .hero:
			return 4
		case .legend:
			return 5
		}
	}
}


enum RuneError: Error {
	case duplicateError
	case deleteError
	case unknownError
}

// MARK: - Land of Many Enums, Parsing
// com2us mapping of rune values

enum RuneType: Int16 {
	case energy = 1, guardRune, swift, blade, rage, focus, endure, fatal
	case despair = 10, vampire, violent = 13, nemesis, will, shield, revenge
	case destroy, fight, determination, enhance, accuracy, tolerance // tolerance = 23

	var numInSet: Int {
		switch self {
		case .swift, .rage, .fatal, .despair, .vampire, .violent:
			return 4
		default:
			return 2
		}
	}

	var description: String {
		return "\(self)"
	}
}

struct RuneStat: Decodable {
	let stat: Int?
	let statValue: Int?
}

struct RuneSubstat: Decodable {
	let stat: Int?
	let statValue: Int?
	let grind: Int?
	let enchanted: Int?
}

// MARK: - Land of Many Enums, Display

enum RuneStatType: Int16 {
	case hpFlat = 1
	case hpPct
	case atkFlat
	case atkPct
	case defFlat
	case defPct
	case speed = 8 // because why
	case critRatePct
	case critDmgPct
	case resistPct
	case accuracyPct


	func intValue() -> Int16 {
		switch self {
		case .hpFlat:
			return 1
		case .hpPct:
			return 2
		case .atkFlat:
			return 3
		case .atkPct:
			return 4
		case .defFlat:
			return 5
		case .defPct:
			return 5
		case .speed:
			return 8
		case .critRatePct:
			return 9
		case .critDmgPct:
			return 10
		case .resistPct:
			return 11
		case .accuracyPct:
			return 12
		}
	}

	func statArray() -> [[Int]] {
		switch self {
		case .hpFlat:
			return [[40, 85, 130, 175, 220, 265, 310, 355, 400, 445, 490, 535, 580, 625, 670, 804],
					[70, 130, 190, 250, 310, 370, 430, 490, 550, 610, 670, 730, 790, 850, 910, 1092],
					[100, 175, 250, 325, 400, 475, 550, 625, 700, 775, 850, 925, 1000, 1075, 1150, 1380],
					[160, 250, 340, 430, 520, 610, 700, 790, 880, 970, 1060, 1150, 1240, 1330, 1420, 1704],
					[270, 375, 480, 585, 690, 795, 900, 1005, 1110, 1215, 1320, 1425, 1530, 1635, 1740, 2088],
					[360, 480, 600, 720, 840, 960, 1080, 1200, 1320, 1440, 1560, 1680, 1800, 1920, 2040, 2448]]
		case .hpPct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 38],
					[5, 7, 9, 11, 13, 16, 18, 20, 22, 24, 27, 29, 31, 33, 36, 43],
					[8, 10, 12, 15, 17, 20, 22, 24, 27, 29, 32, 34, 37, 40, 43, 51],
					[11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 63]]
		case .atkFlat:
			return [[3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 54],
					[5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 73],
					[7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67, 72, 77, 92],
					[10, 16, 22, 28, 34, 40, 46, 52, 58, 64, 70, 76, 82, 88, 94, 112],
					[15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92, 99, 106, 113, 135],
					[22, 30, 38, 46, 54, 62, 70, 78, 86, 94, 102, 110, 118, 126, 134, 160]]
		case .atkPct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 38],
					[5, 7, 9, 11, 13, 16, 18, 20, 22, 24, 27, 29, 31, 33, 36, 43],
					[8, 10, 12, 15, 17, 20, 22, 24, 27, 29, 32, 34, 37, 40, 43, 51],
					[11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 63]]
		case .defFlat:
			return [[3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 54],
					[5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 73],
					[7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67, 72, 77, 92],
					[10, 16, 22, 28, 34, 40, 46, 52, 58, 64, 70, 76, 82, 88, 94, 112],
					[15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92, 99, 106, 113, 135],
					[22, 30, 38, 46, 54, 62, 70, 78, 86, 94, 102, 110, 118, 126, 134, 160]]
		case .defPct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 38],
					[5, 7, 9, 11, 13, 16, 18, 20, 22, 24, 27, 29, 31, 33, 36, 43],
					[8, 10, 12, 15, 17, 20, 22, 24, 27, 29, 32, 34, 37, 40, 43, 51],
					[11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 63]]
		case .speed:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[3, 4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 19, 21, 25],
					[4, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20, 22, 23, 25, 30],
					[5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 39],
					[7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 42]]
		case .critRatePct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 37],
					[4, 6, 8, 11, 13, 15, 17, 19, 22, 24, 26, 28, 30, 33, 35, 41],
					[5, 7, 10, 12, 15, 17, 19, 22, 24, 27, 29, 31, 34, 36, 39, 47],
					[7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 58]]
		case .critDmgPct:
			return [[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 37],
					[4, 6, 9, 11, 13, 16, 18, 20, 22, 25, 27, 29, 32, 34, 36, 43],
					[6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 57],
					[8, 11, 15, 18, 21, 25, 28, 31, 34, 38, 41, 44, 48, 51, 54, 65],
					[11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 80]]
		case .resistPct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 38],
					[6, 8, 10, 13, 15, 17, 19, 21, 24, 26, 28, 30, 32, 35, 37, 44],
					[9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35, 38, 40, 43, 51],
					[12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 64]]
		case .accuracyPct:
			return [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18],
					[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19],
					[4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 38],
					[6, 8, 10, 13, 15, 17, 19, 21, 24, 26, 28, 30, 32, 35, 37, 44],
					[9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35, 38, 40, 43, 51],
					[12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 64]]
			}
	}

	func statValue(stars: Int16, level: Int16) -> Int {
		guard stars >= 1 && stars <= 6 else {
			return 0
		}

		guard level >= 0 && level <= 15 else {
			return 0
		}
		
		let statsByLevel = self.statArray()
		return statsByLevel[Int(stars) - 1][Int(level) - 1]
	}
}

enum InnateStatTitle: String {
	case hpFlat = "Strong"
	case hpPct = "Tenacious"
	case atkFlat = "Ferocious"
	case atkPct = "Powerful"
	case defFlat = "Sturdy"
	case defPct = "Durable"
	case speed = "Quick"
	case critRatePct = "Mortal"
	case critDmgPct = "Cruel"
	case resistPct = "Resistant"
	case accuracyPct = "Intricate"
}
