//
//  BuildingInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import CoreData

@objc(BuildingInstance)
public class BuildingInstance: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "deco_id"
        case summonerId = "wizard_id"
        case buildingId = "master_id"
        case level
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for BuildingInstance]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "BuildingInstance", in: context) else { fatalError("Could not get entity [for BuildingInstance]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.buildingId = try container.decode(Int64.self, forKey: .buildingId)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.level = try container.decode(Int64.self, forKey: .level)

        self.building = Building.findById(self.buildingId, context: context)
        self.summoner = Summoner.findById(self.summonerId, context: context)
    }
}

//extension BuildingInstance: CoreDataUtility {
extension BuildingInstance {

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
    
    static func findBySummonerAndBuildingId(_ summoner: Int64?, _ buildingId: Int64,
                                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> BuildingInstance? {
        
        guard let sId = summoner else {
            return nil
        }
        
        let request : NSFetchRequest<BuildingInstance> = BuildingInstance.fetchRequest()
        
        let firstPredicate = NSPredicate(format: "summonerId = %i", sId)
        let secondPredicate = NSPredicate(format: "buildingId = %i", buildingId)
        let predicate = firstPredicate.and(secondPredicate)

        request.predicate = predicate
        
        if let results = try? context.fetch(request) {

            if let buildingInstance = results.first {
                return buildingInstance
            }
        }
        return nil
    }
    
    static func getBuildingLevel(_ summoner: Int64?, _ buildingId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Int64 {
        let bi = BuildingInstance.findBySummonerAndBuildingId(summoner, buildingId, context: context)
        return bi?.level ?? 0 // zero means "no such building" but is suppressed on output in views
    }
    
    static func filteredBuildingInstances(_ buildingFilter: BuildingFilter, summoner: Summoner?) -> [BuildingInstance] {
        switch buildingFilter {
        case .battle:
            if let s: Int64 = summoner?.id {
                return BuildingInstance.battleList(s)
            } else {
                let bi: [BuildingInstance] = []
                return bi
            }
        case .elemental:
            if let s: Int64 = summoner?.id {
                return BuildingInstance.elementalList(s)
            } else {
                let bi: [BuildingInstance] = []
                return bi
            }

        case .guild:
            if let s: Int64 = summoner?.id {
                return BuildingInstance.guildList(s)
            } else {
                let bi: [BuildingInstance] = []
                return bi
            }
        case .arena:
            if let s: Int64 = summoner?.id {
                return BuildingInstance.arenaList(s)
            } else {
                let bi: [BuildingInstance] = []
                return bi
            }
        case .none:
            return []   // TODO
        }
    }

    
    func getBuildingBonus() -> Int64 {
        var bonus: Int64 = 0
        
        let levels = self.building?.statBonus
        bonus = levels?[Int(self.level)] ?? 0
        
        return bonus
    }
    
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let buildingInstanceData = from as! BuildingInstanceData
//
//        // don't dirty the record if you don't have to
//
//        if self.id != buildingInstanceData.com2usId {
//            self.id = buildingInstanceData.com2usId
//        }
//        if self.buildingId != buildingInstanceData.buildingId {
//            self.buildingId = buildingInstanceData.buildingId
//
//            self.building = Building.findById(buildingInstanceData.com2usId, context: docInfo.taskContext)
//        }
//        if self.summonerId != buildingInstanceData.summonerId {
//            self.summonerId = buildingInstanceData.summonerId
//
//            self.summoner = Summoner.findById(buildingInstanceData.summonerId, context: docInfo.taskContext)
//        }
//        if self.level != buildingInstanceData.level {
//            self.level = buildingInstanceData.level
//        }
//
//        if (self.building == nil) {
//            self.building = Building.findById(buildingInstanceData.com2usId, context: docInfo.taskContext)
//        }
//
//        if (self.summoner == nil) {
//            self.summoner = Summoner.findById(buildingInstanceData.summonerId, context: docInfo.taskContext)
//        }
//    }
//
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                                             docInfo: SummonerDocumentInfo) {
//        docInfo.taskContext.performAndWait {
//            let buildingInstanceData = from as! BuildingInstanceData
//            var buildingInstance = BuildingInstance.findById(buildingInstanceData.com2usId, context: docInfo.taskContext) ?? BuildingInstance(context: docInfo.taskContext)
//            buildingInstance.update(from: buildingInstanceData, docInfo: docInfo)
//        }
//    }
//
//    static func batchUpdate<T: JsonArray>(from: [T],
//                                          docInfo: SummonerDocumentInfo) {
//        let buildings = from as! [BuildingInstanceData]
//        for building in buildings {
//            BuildingInstance.insertOrUpdate(from: building, docInfo: docInfo)
//        }
//    }
    static func battleList(_ summoner: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [BuildingInstance] {
        var buildingList: [BuildingInstance] = []
        
        for b in BattleBuilding.battleBuildings() {
            if let building = BuildingInstance.findBySummonerAndBuildingId(summoner, b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func elementalList(_ summoner: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [BuildingInstance] {
        var buildingList: [BuildingInstance] = []
        
        for b in BattleBuilding.elementalBuildings() {
            if let building = BuildingInstance.findBySummonerAndBuildingId(summoner, b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func guildList(_ summoner: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [BuildingInstance] {
        var buildingList: [BuildingInstance] = []
        
        for b in BattleBuilding.guildBuildings() {
            if let building = BuildingInstance.findBySummonerAndBuildingId(summoner, b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
    
    static func arenaList(_ summoner: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> [BuildingInstance] {
        var buildingList: [BuildingInstance] = []
        
        for b in BattleBuilding.arenaBuildings() {
            if let building = BuildingInstance.findBySummonerAndBuildingId(summoner, b.rawValue, context: context) {
                buildingList.append(building)
            }
        }
        return buildingList
    }
}
