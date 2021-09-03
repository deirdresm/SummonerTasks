//
//  HomunculusSkil.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData

// MARK: - Core Data HomunculusSkill

@objc(HomunculusSkill)
public class HomunculusSkill: NSManagedObject, Comparable, Decodable {

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

    public static func < (lhs: HomunculusSkill, rhs: HomunculusSkill) -> Bool {
        lhs.id < rhs.id
    }

    static func findById(id: Int64,
                    context: NSManagedObjectContext) -> HomunculusSkill? {
        
        let request : NSFetchRequest<HomunculusSkill> = HomunculusSkill.fetchRequest()

        request.predicate = NSPredicate(format: "id == %i", id)
        
        let results = try? context.fetch(request)
        
        if let _ = results?.count {
            return(results?.first)
        } else {
            return(nil)
        }
    }

    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let skillData = from as! HomunculusSkillData
        
        // don't dirty the record if you don't have to
        
        if self.id != skillData.id {
            self.id = Int64(skillData.id)
        }
        if self.skillId != skillData.skill {
            self.skillId = skillData.skill
        }
        if self.monsterIds != skillData.monsters {
            self.monsterIds = skillData.monsters
        }
        if self.prerequisites != skillData.prerequisites {
            self.prerequisites = skillData.prerequisites
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        let skillData = from as! HomunculusSkillData
        let skill: HomunculusSkill = HomunculusSkill.findById(id: skillData.id, context: docInfo.taskContext) ??
            HomunculusSkill(context: docInfo.taskContext)
        
        skill.update(from: skillData, docInfo: docInfo)
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let skills = from as! [HomunculusSkillData]
        for skill in skills {
            HomunculusSkill.insertOrUpdate(from: skill, docInfo: docInfo)
        }
    }
}

// MARK: - Core Data HomunculusSkillcraftCost

@objc(HomunculusSkillcraftCost)
public class HomunculusSkillcraftCost: NSManagedObject, Comparable, Decodable {

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


    public static func < (lhs: HomunculusSkillcraftCost, rhs: HomunculusSkillcraftCost) -> Bool {
        lhs.id < rhs.id
    }

    convenience init(skillData: HomunculusSkillcraftData) {
        self.init()
        update(skillData)
    }
    
    func update(_ skillData: HomunculusSkillcraftData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != skillData.id {
            self.id = Int64(skillData.id)
        }
        if self.item != skillData.item {
            self.item = Int64(skillData.item)
        }
        if self.quantity != skillData.quantity {
            self.quantity = Int64(skillData.quantity)
        }
        if self.skill != skillData.skill {
            self.skill = skillData.skill
        }
    }
    
    static func insertOrUpdate(skillData: HomunculusSkillcraftData,
                               docInfo: SummonerDocumentInfo) {
        var skill: HomunculusSkillcraftCost!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<HomunculusSkillcraftCost> = HomunculusSkillcraftCost.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillData.id)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = HomunculusSkillcraftCost(context: docInfo.taskContext)
                skill.update(skillData)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillData)
             }
        }
    }
    
    static func batchUpdate(from skills: [HomunculusSkillcraftData],
                            docInfo: SummonerDocumentInfo) {
        for skill in skills {
            HomunculusSkillcraftCost.insertOrUpdate(skillData: skill, docInfo: docInfo)
        }
    }
}
