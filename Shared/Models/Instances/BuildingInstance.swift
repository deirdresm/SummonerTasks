//
//  BuildingInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData

extension BuildingInstance {
    
    convenience init(buildingInstanceData: BuildingInstanceData, docInfo: SummonerDocumentInfo) {
        self.init()
        update(buildingInstanceData, docInfo: docInfo)
    }
    
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
    
    func update(_ buildingInstanceData: BuildingInstanceData, docInfo: SummonerDocumentInfo) {
        
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
    
    static func insertOrUpdate(_ buildingInstanceData: BuildingInstanceData,
                               docInfo: SummonerDocumentInfo) {
        let buildingInstance: BuildingInstance!
        
        docInfo.taskContext.performAndWait {
            var buildingInstance = BuildingInstance.findById(buildingInstanceData.com2usId, context: docInfo.taskContext) ?? BuildingInstance(context: docInfo.taskContext)
            buildingInstance.update(buildingInstanceData, docInfo: docInfo)
        }
    }
    
    static func batchUpdate(from buildings: [BuildingInstanceData],
                            docInfo: SummonerDocumentInfo) {
        for building in buildings {
            print(building)
            BuildingInstance.insertOrUpdate(building, docInfo: docInfo)
        }
    }
}
