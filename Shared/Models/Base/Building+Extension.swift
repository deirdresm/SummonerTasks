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

	public convenience init(json: JSON, pk: Int64, context: NSManagedObjectContext) {
		// get the context and the entity in the context
		guard let entity = NSEntityDescription.entity(forEntityName: "Building", in: context) else { fatalError("Could not get entity [for Building]") }

		// init self
		self.init(entity: entity, insertInto: context)

		id = json.pk.int
		name = json.fields.name.string
		com2usId = json.fields.com2us_id.int
		maxLevel = json.fields.max_level.int
		area = json.fields.area.optionalNumber
		affectedStat = json.fields.affected_stat.optionalNumber
		element = json.fields.element.optionalString
		c2uDescription = json.fields.description.string
		imageFilename = json.fields.icon_filename.string

		var jsonArr = json.fields.stat_bonus.value
		var converted = try! JSON(string: jsonArr as! String).array
		statBonus = converted.map {try! JSON(string: $0.value as! String).int}

		jsonArr = json.fields.upgrade_cost.value
		converted = try! JSON(string: jsonArr as! String).array
		upgradeCost =  converted.map {try! JSON(string: $0.value as! String).int}
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "Building", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
//		let fields: [String: AnyObject] = try container.decode([String: AnyObject].self, forKey: .fields)
//
//		if let field = fields["com2us_id"] {
//			self.id = field
//		}
//
//		self.id = (fields["com2us_id"]) as? Int64
//		self.name = (fields["name"]).orEmpty
//		self.c2uDescription = (fields["description"]).orEmpty
//		self.maxLevel = (fields["max_level"]) as! Int64
//		self.area = (fields["area"]) as! Int64
//		self.affectedStat = (fields["affected_stat"]) as! Int64
//		self.imageFilename = (fields["icon_filename"]).orEmpty
//		self.statBonus = (fields["stat_bonus"]).orIntArray
//		self.upgradeCost = (fields["upgradeCost"]).orIntArray
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
