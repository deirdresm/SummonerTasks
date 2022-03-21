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
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.com2usId = try container.decode(Int64.self, forKey: .com2usId)
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

/*
 CREATE TABLE public.bestiary_building
 (
     id integer NOT NULL DEFAULT nextval('bestiary_building_id_seq'::regclass),
     com2us_id integer NOT NULL,
     name character varying(30) COLLATE pg_catalog."default" NOT NULL,
     max_level integer NOT NULL,
     area integer,
     affected_stat integer,
     element character varying(6) COLLATE pg_catalog."default",
     stat_bonus integer[] NOT NULL,
     upgrade_cost integer[] NOT NULL,
     description text COLLATE pg_catalog."default",
     icon_filename character varying(100) COLLATE pg_catalog."default",
     CONSTRAINT bestiary_building_pkey PRIMARY KEY (id)
 )
 WITH (
     OIDS = FALSE
 )
 */
