//
//  Building.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/10/20.
//

import Foundation
import CoreData

/**
 Managed object class for the Building entity.
 */

// MARK: - Core Data

@objc(Building)
public class Building: NSManagedObject, Comparable, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case attribute
        case amount
        case area
        case element
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        id = try container.decode(Int64.self, forKey: .id)
        attribute = try container.decode(Int64.self, forKey: .attribute)
        amount = try container.decode(Int64.self, forKey: .amount)
        area = try container.decode(Int64.self, forKey: .area)
        element = try container.decode(String.self, forKey: .element)
    }


    // MARK: - Comparable conformance

    public static func < (lhs: Building, rhs: Building) -> Bool {
        lhs.id < rhs.id
    }

    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let buildingData = from as! BuildingData
        
        // don't dirty the record if you don't have to
        
        if self.id != buildingData.id {
            self.id = Int64(buildingData.id)
        }
        if self.name != buildingData.name {
            self.name = buildingData.name
        }
        if self.com2usId != buildingData.com2usId {
            self.com2usId = buildingData.com2usId
        }
        if self.maxLevel != buildingData.maxLevel {
            self.maxLevel = buildingData.maxLevel
        }
        if self.area != buildingData.area {
            self.area = buildingData.area ?? 0
        }
        if self.affectedStat != buildingData.affectedStat {
            self.affectedStat = buildingData.affectedStat ?? 0
        }
        if self.element != buildingData.element {
           self.element = buildingData.element
        }
        if self.c2uDescription != buildingData.description {
            self.c2uDescription = buildingData.description
        }
        if self.imageFilename != buildingData.imageFilename {
            self.imageFilename = buildingData.imageFilename
        }
        if self.statBonus != buildingData.statBonus {
            self.statBonus = buildingData.statBonus
        }
        if self.upgradeCost != buildingData.upgradeCost {
            self.upgradeCost = buildingData.upgradeCost
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        var building: Building!
        let buildingData = from as! BuildingData
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<Building> = Building.fetchRequest()

            let predicate = NSPredicate(format: "com2usId == %i", buildingData.com2usId)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                building = Building(context: docInfo.taskContext)
                building.update(from: buildingData, docInfo: docInfo)
             } else {
                // update existing
                building = results?.first
                building.update(from: buildingData, docInfo: docInfo)
             }
        }
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let buildings = from as! [BuildingData]
        
        for building in buildings {
            Building.insertOrUpdate(from: building, docInfo: docInfo)
        }
    }
    
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
    
    static func battleList(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.battleBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func elementalList(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.elementalBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func guildList(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [Building] {
        var buildingList: [Building] = []
        
        for b in BattleBuilding.guildBuildings() {
            if let building = Building.findById(b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func arenaList(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [Building] {
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
