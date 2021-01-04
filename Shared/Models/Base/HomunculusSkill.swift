//
//  HomunculusSkil.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation
import CoreData


// MARK: - Core Data HomunculusSkill

extension HomunculusSkill {
    
    convenience init(skillData: HomunculusSkillData) {
        self.init()
        update(skillData)
    }
    
    func update(_ skillData: HomunculusSkillData) {
        
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
    
    static func insertOrUpdate(skillData: HomunculusSkillData,
                               context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        var skill: HomunculusSkill!
        
        context.performAndWait {
            let request : NSFetchRequest<HomunculusSkill> = HomunculusSkill.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillData.id)

            request.predicate = predicate
            
            let results = try? context.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = HomunculusSkill(context: context)
                skill.update(skillData)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillData)
             }
        }
    }
    
    static func batchUpdate(from skills: [HomunculusSkillData],
                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        for skill in skills {
            HomunculusSkill.insertOrUpdate(skillData: skill, context: context)
        }
    }
}

// MARK: - Core Data HomunculusSkillcraftCost

extension HomunculusSkillcraftCost {
    
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
                               context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        var skill: HomunculusSkillcraftCost!
        
        context.performAndWait {
            let request : NSFetchRequest<HomunculusSkillcraftCost> = HomunculusSkillcraftCost.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillData.id)

            request.predicate = predicate
            
            let results = try? context.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = HomunculusSkillcraftCost(context: context)
                skill.update(skillData)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillData)
             }
        }
    }
    
    static func batchUpdate(from skills: [HomunculusSkillcraftData],
                            context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        for skill in skills {
            HomunculusSkillcraftCost.insertOrUpdate(skillData: skill, context: context)
        }
    }
}
