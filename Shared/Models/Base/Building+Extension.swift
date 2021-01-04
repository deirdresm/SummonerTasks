//
//  Building.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/10/20.
//

import Foundation
import CoreData

// MARK: - Core Data

extension Building {
    convenience init(buildingData: BuildingData) {
        self.init()
        update(from: buildingData)
    }
    
    func update(from buildingData: BuildingData) {
        
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
    
    static func insertOrUpdate(from buildingData: BuildingData,
                               context: NSManagedObjectContext) {
        var building: Building!
        
        context.performAndWait {
            let request : NSFetchRequest<Building> = Building.fetchRequest()

            let predicate = NSPredicate(format: "com2usId == %i", buildingData.com2usId)

            request.predicate = predicate
            
            let results = try? context.fetch(request)

            if results?.count == 0 {
                // insert new
                building = Building(context: context)
                building.update(from: buildingData)
             } else {
                // update existing
                building = results?.first
                building.update(from: buildingData)
             }
        }
    }
    
    static func batchUpdate(from buildings: [BuildingData],
                            context: NSManagedObjectContext) {
        for building in buildings {
            Building.insertOrUpdate(from: building, context: context)
        }
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
