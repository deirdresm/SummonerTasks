//
//  BuildingInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData

extension BuildingInstance {
    
    convenience init(buildingInstanceData: BuildingInstanceData) {
        self.init()
        update(buildingInstanceData)
    }
    
    static func findBuildingInstanceById(_ buildingInstanceId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> BuildingInstance? {
        
        let request : NSFetchRequest<BuildingInstance> = BuildingInstance.fetchRequest()

        request.predicate = NSPredicate(format: "com2usId = %@", buildingInstanceId)
        
        if let results = try? context.fetch(request) {
        
            if let buildingInstance = results.first {
                return buildingInstance
            }
        }
        return nil
    }
    
    func update(_ buildingInstanceData: BuildingInstanceData) {
        
        // don't dirty the record if you don't have to
        
        if self.com2usId != buildingInstanceData.com2usId {
            self.com2usId = buildingInstanceData.com2usId
        }
        if self.buildingId != buildingInstanceData.buildingId {
            self.buildingId = buildingInstanceData.buildingId
            // TODO: add object
        }
        if self.summonerId != buildingInstanceData.summonerId {
            self.summonerId = buildingInstanceData.summonerId
            // TODO: add object
        }
        if self.level != buildingInstanceData.level {
            self.level = buildingInstanceData.level
        }
    }
    
    static func insertOrUpdate(buildingInstanceData: BuildingInstanceData,
                               context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        let buildingInstance: BuildingInstance!
        
        let request : NSFetchRequest<BuildingInstance> = BuildingInstance.fetchRequest()

        request.predicate = NSPredicate(format: "com2usId = %@", buildingInstanceData.com2usId)
        
        let results = try? context.fetch(request)

        if results?.count == 0 {
            // insert new
            buildingInstance = BuildingInstance(context: context)
            buildingInstance.update(buildingInstanceData)
         } else {
            // update existing
            buildingInstance = results?.first
            buildingInstance.update(buildingInstanceData)
         }
    }
    
    static func batchUpdate(buildings: [BuildingInstanceData],
                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        for building in buildings {
            print(building)
            BuildingInstance.insertOrUpdate(buildingInstanceData: building, context: context)
        }
    }


    
}
