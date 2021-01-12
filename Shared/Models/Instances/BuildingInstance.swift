//
//  BuildingInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData

extension BuildingInstance: CoreDataUtility {
    
    static func findById(_ buildingInstanceId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> BuildingInstance? {
        
        let request : NSFetchRequest<BuildingInstance> = BuildingInstance.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", buildingInstanceId)
        
        if let results = try? context.fetch(request) {
        
            if let buildingInstance = results.first {
                return buildingInstance
            }
        }
        return nil
    }
    
    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let buildingInstanceData = from as! BuildingInstanceData
        
        // don't dirty the record if you don't have to
        
        if self.id != buildingInstanceData.com2usId {
            self.id = buildingInstanceData.com2usId
        }
        if self.buildingId != buildingInstanceData.buildingId {
            self.buildingId = buildingInstanceData.buildingId

            self.building = Building.findById(buildingInstanceData.com2usId, context: docInfo.taskContext)
        }
        if self.summonerId != buildingInstanceData.summonerId {
            self.summonerId = buildingInstanceData.summonerId

            self.summoner = Summoner.findById(buildingInstanceData.summonerId, context: docInfo.taskContext)
        }
        if self.level != buildingInstanceData.level {
            self.level = buildingInstanceData.level
        }
        
        if (self.building == nil) {
            self.building = Building.findById(buildingInstanceData.com2usId, context: docInfo.taskContext)
        }
        
        if (self.summoner == nil) {
            self.summoner = Summoner.findById(buildingInstanceData.summonerId, context: docInfo.taskContext)
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        docInfo.taskContext.performAndWait {
            let buildingInstanceData = from as! BuildingInstanceData
            var buildingInstance = BuildingInstance.findById(buildingInstanceData.com2usId, context: docInfo.taskContext) ?? BuildingInstance(context: docInfo.taskContext)
            buildingInstance.update(from: buildingInstanceData, docInfo: docInfo)
        }
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let buildings = from as! [BuildingInstanceData]
        for building in buildings {
            BuildingInstance.insertOrUpdate(from: building, docInfo: docInfo)
        }
    }
}
