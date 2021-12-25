//
//  RuneInstance+CoreDataClass.swift
//  
//
//  Created by Deirdre Saoirse Moen on 1/24/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(RuneInstance)
public class RuneInstance: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "rune_id"
        case summonerId = "wizard_id"
        case occupiedType = "occupied_type"
        case assignedToId = "occupied_id"
        case slot = "slot_no"
        case level = "upgrade_curr"
        case stars = "class"
//        case setId
        case runeType = "set_id"
        case upgradeLimit = "upgrade_limit"
//        case upgradeCurr = "upgrade_curr"
//        case baseValue = "base_value"
        case runeValue = "sell_value"
        case priEff = "pri_eff"
        case prefixEff = "prefix_eff"
        case secEff = "sec_eff"
        case quality = "rank"
        case originalQuality = "extra"
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for RuneInstance]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "RuneInstance", in: context) else { fatalError("Could not get entity [for RuneInstance]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.summoner = Summoner.findById(self.summonerId, context: context)
//        self.occupiedType = try container.decode(Int64.self, forKey: .occupiedType)
        self.assignedToId = try container.decode(Int64.self, forKey: .assignedToId)
        self.slot = try container.decode(Int16.self, forKey: .slot)
        self.level = try container.decode(Int16.self, forKey: .level)
        let stars = try container.decode(Int16.self, forKey: .stars)
		starsRawToStars(stars)

		self.quality = try container.decode(Int16.self, forKey: .quality)
		self.originalQuality = try container.decode(Int16.self, forKey: .originalQuality)
        
        self.runeType = try container.decode(Int16.self, forKey: .runeType)
        self.runeValue = try container.decode(Int32.self, forKey: .runeValue)
        
        let priEff = try container.decode([Int32].self, forKey: .priEff)
        self.mainStat = Int16(priEff[0])
        self.mainStatValue = Int64(priEff[1])
        
        let prefixEff = try container.decode([Int32].self, forKey: .prefixEff)
        self.innateStat = Int64(prefixEff[0])
        self.innateStatValue = Int64(prefixEff[1])
        
        let secEff = try container.decode([[Int32]].self, forKey: .secEff)
		let numStats = secEff.count
		
		if numStats > 0 {
			if secEff[0].count > 0 {
				self.substat1 = Int64(secEff[0][0])
				self.substat1Value = Int64(secEff[0][1])
				self.substat1Enchanted = Int64(secEff[0][2]) != 0
				self.substat1Craft = Int64(secEff[0][3])
				
				self.setStat(RuneStatType(rawValue: Int16(self.substat1))!, value: self.substat1Value)
			}
		}
		
		if numStats > 1 {
			if secEff[1].count > 0 {
				self.substat2 = Int64(secEff[1][0])
				self.substat2Value = Int64(secEff[1][1])
				self.substat2Enchanted = Int64(secEff[1][2]) != 0
				self.substat2Craft = Int64(secEff[1][3])
				
				self.setStat(RuneStatType(rawValue: Int16(self.substat2))!, value: self.substat2Value)
			}
		}
		
		if numStats > 2 {
			if secEff[2].count > 0 {
				self.substat3 = Int64(secEff[2][0])
				self.substat3Value = Int64(secEff[2][1])
				self.substat3Enchanted = Int64(secEff[2][2]) != 0
				self.substat3Craft = Int64(secEff[2][3])
				
				self.setStat(RuneStatType(rawValue: Int16(self.substat3))!, value: self.substat3Value)
			}
		}
		
		if numStats > 3 {
			if secEff[3].count > 0 {
				self.substat4 = Int64(secEff[3][0])
				self.substat4Value = Int64(secEff[3][1])
				self.substat4Enchanted = Int64(secEff[3][2]) != 0
				self.substat4Craft = Int64(secEff[3][3])
				
				self.setStat(RuneStatType(rawValue: Int16(self.substat4))!, value: self.substat4Value)
			}
		}
    }

	/// For encoding CoreData back to JSON
	func starsToStarsRaw() -> Int16 {

		if ancient {
			return stars + 10
		} else {
			return stars
		}
	}

	/// parse JSON for whether it's an ancient rune or not
	func starsRawToStars(_ numStars: Int16) {
		if stars < 10 {
			self.stars = stars
			self.ancient = false
		} else {
			self.stars = stars - 10
			self.ancient = true
		}
	}

	/// Encoding helper for primary stat
	func priEffArray() -> [Int] {
		return [Int(mainStat), Int(mainStatValue)]
	}

	/// Encoding helper for innate stat
	func prefixEffArray() -> [Int] {
		return [Int(innateStat), Int(innateStatValue)]
	}

	/// Encoding helper for substats
	func substatArray() -> [[Int64]] {
		var substats: [[Int64]] = []

		if substat1 > 0 {
			substats.append([substat1, substat1Value, substat1Enchanted ? 1 : 0, substat1Craft])
		}

		if substat2 > 0 {
			substats.append([substat2, substat2Value, substat2Enchanted ? 1 : 0, substat2Craft])
		}

		if substat3 > 0 {
			substats.append([substat3, substat3Value, substat3Enchanted ? 1 : 0, substat3Craft])
		}

		if substat4 > 0 {
			substats.append([substat4, substat4Value, substat4Enchanted ? 1 : 0, substat4Craft])
		}
		return substats
	}

	/// Encodable conformance requirement (encode)
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(id, forKey: .id)
		try container.encode(summonerId, forKey: .summonerId)
		try container.encode(assignedToId, forKey: .assignedToId)
		try container.encode(slot, forKey: .slot)
		try container.encode(level, forKey: .level)
		try container.encode(starsToStarsRaw(), forKey: .stars)

		try container.encode(quality, forKey: .quality)
		try container.encode(originalQuality, forKey: .originalQuality)
		try container.encode(runeType, forKey: .runeType)
		try container.encode(runeValue, forKey: .runeValue)

		try container.encode(priEffArray(), forKey: .priEff)
		try container.encode(prefixEffArray(), forKey: .prefixEff)


		let secEff = try container.decode([[Int32]].self, forKey: .secEff)
		let numStats = secEff.count

		if numStats > 0 {
			if secEff[0].count > 0 {
				self.substat1 = Int64(secEff[0][0])
				self.substat1Value = Int64(secEff[0][1])
				self.substat1Enchanted = Int64(secEff[0][2]) != 0
				self.substat1Craft = Int64(secEff[0][3])

				self.setStat(RuneStatType(rawValue: Int16(self.substat1))!, value: self.substat1Value)
			}
		}

		if numStats > 1 {
			if secEff[1].count > 0 {
				self.substat2 = Int64(secEff[1][0])
				self.substat2Value = Int64(secEff[1][1])
				self.substat2Enchanted = Int64(secEff[1][2]) != 0
				self.substat2Craft = Int64(secEff[1][3])

				self.setStat(RuneStatType(rawValue: Int16(self.substat2))!, value: self.substat2Value)
			}
		}

		if numStats > 2 {
			if secEff[2].count > 0 {
				self.substat3 = Int64(secEff[2][0])
				self.substat3Value = Int64(secEff[2][1])
				self.substat3Enchanted = Int64(secEff[2][2]) != 0
				self.substat3Craft = Int64(secEff[2][3])

				self.setStat(RuneStatType(rawValue: Int16(self.substat3))!, value: self.substat3Value)
			}
		}

		if numStats > 3 {
			if secEff[3].count > 0 {
				self.substat4 = Int64(secEff[3][0])
				self.substat4Value = Int64(secEff[3][1])
				self.substat4Enchanted = Int64(secEff[3][2]) != 0
				self.substat4Craft = Int64(secEff[3][3])

				self.setStat(RuneStatType(rawValue: Int16(self.substat4))!, value: self.substat4Value)
			}
		}
	}
	
	func calcSubstatsEnchanted() {
		if self.substat1Enchanted || self.substat2Enchanted || self.substat3Enchanted || self.substat4Enchanted {
			self.substatsEnchanted = true
		} else {
			self.substatsEnchanted = false
		}
	}
}
