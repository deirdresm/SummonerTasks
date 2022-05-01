//
//  Building.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/10/20.
//

import Foundation
import CoreData

// MARK: - Core Data

@objc(Building)
public class Building: NSManagedObject, Decodable {
//extension Building: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case fields
		case name
		case com2usId = "com2us_id"
		case maxLevel
		case area
		case affectedStat
		case element
		case statBonus
		case upgradeCost
		case upgradeLimit
		case description
		case imageFilename
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "Building", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.id = (fields["com2us_id"]).orInt
		self.name = (fields["name"]).orEmpty
		self.c2uDescription = (fields["description"]).orEmpty
		self.maxLevel = (fields["max_level"]).orInt
		self.area = (fields["area"]).orInt
		self.affectedStat = (fields["affected_stat"]).orInt
		self.imageFilename = (fields["icon_filename"]).orEmpty
		self.statBonus = (fields["stat_bonus"]).orIntArray
		self.upgradeCost = (fields["upgradeCost"]).orIntArray
	}

	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

    static func filteredBuildings(_ buildingFilter: BuildingFilter) -> [Building] {
        switch buildingFilter {
        case .battle:
            return Building.battleList()
        case .guild:
            return Building.guildList()
        case .elemental:
            return Building.elementalList()
        case .arena:
            return Building.arenaList()
        case .none:
            return []   // TODO
        }
    }

    static func battleList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.battleBuildings() {
            if let building = Building.findById(b.rawValue, context: context) as? Building {
                buildingList.append(building)
            }
        }
        return buildingList
    }

    static func elementalList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []

        for b in BattleBuilding.elementalBuildings() {
            if let building = Building.findById(b.rawValue, context: context) as? Building {
                buildingList.append(building)
            }
        }
        return buildingList
    }

    static func guildList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.guildBuildings() {
            if let building = Building.findById(b.rawValue, context: context) as? Building {
                buildingList.append(building)
            }
        }
        return buildingList
    }

    static func arenaList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.arenaBuildings() {
            if let building = Building.findById(b.rawValue, context: context) as? Building {
                buildingList.append(building)
            }
        }
        return buildingList
    }
}
