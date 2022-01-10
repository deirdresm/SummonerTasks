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

	//    convenience init(buildingData: BuildingData, docInfo: SummonerDocumentInfo) {
//        self.init()
//        update(from: buildingData, docInfo: docInfo)
//    }
//    
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let buildingData = from as! BuildingData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != buildingData.id {
//            self.id = Int64(buildingData.id)
//        }
//        if self.name != buildingData.name {
//            self.name = buildingData.name
//        }
//        if self.com2usId != buildingData.com2usId {
//            self.com2usId = buildingData.com2usId
//        }
//        if self.maxLevel != buildingData.maxLevel {
//            self.maxLevel = buildingData.maxLevel
//        }
//        if self.area != buildingData.area {
//            self.area = buildingData.area ?? 0
//        }
//        if self.affectedStat != buildingData.affectedStat {
//            self.affectedStat = buildingData.affectedStat ?? 0
//        }
//        if self.element != buildingData.element {
//           self.element = buildingData.element
//        }
//        if self.c2uDescription != buildingData.description {
//            self.c2uDescription = buildingData.description
//        }
//        if self.imageFilename != buildingData.imageFilename {
//            self.imageFilename = buildingData.imageFilename
//        }
//        if self.statBonus != buildingData.statBonus {
//            self.statBonus = buildingData.statBonus
//        }
//        if self.upgradeCost != buildingData.upgradeCost {
//            self.upgradeCost = buildingData.upgradeCost
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        var building: Building!
//        let buildingData = from as! BuildingData
//        
//        docInfo.taskContext.performAndWait {
//            let request : NSFetchRequest<Building> = Building.fetchRequest()
//
//            let predicate = NSPredicate(format: "com2usId == %i", buildingData.com2usId)
//
//            request.predicate = predicate
//            
//            let results = try? docInfo.taskContext.fetch(request)
//
//            if results?.count == 0 {
//                // insert new
//                building = Building(context: docInfo.taskContext)
//                building.update(from: buildingData, docInfo: docInfo)
//             } else {
//                // update existing
//                building = results?.first
//                building.update(from: buildingData, docInfo: docInfo)
//             }
//        }
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let buildings = from as! [BuildingData]
//        
//        for building in buildings {
//            Building.insertOrUpdate(from: building, docInfo: docInfo)
//        }
//    }
//    
    static func findById(_ id: Int64,
                    context: NSManagedObjectContext) -> Building? {
        
        let request : NSFetchRequest<Building> = Building.fetchRequest()

        request.predicate = NSPredicate(format: "com2usId == %i", id)
        
        let results = try? context.fetch(request)
        
        if let _ = results?.count {
            return(results?.first)
        } else {
            return(nil)
        }
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
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func elementalList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.elementalBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func guildList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.guildBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func arenaList(context: NSManagedObjectContext = Persistence.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.arenaBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
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
