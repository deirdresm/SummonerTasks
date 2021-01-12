//
//  SkillEffect.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data SkillEffect

extension SkillEffect: CoreDataUtility {
    
    static func findById(_ skillDataId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> Skill? {
        
        let request : NSFetchRequest<Skill> = Skill.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillDataId)
        
        if let results = try? context.fetch(request) {
        
            if let skill = results.first {
                return skill
            }
        }
        return nil
    }

    func update(_ skillEffect: SkillEffectData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != skillEffect.id {
            self.id = Int64(skillEffect.id)
        }
        if self.c2uDescription != skillEffect.c2uDescription {
            self.c2uDescription = skillEffect.c2uDescription
        }
        if self.name != skillEffect.name {
            self.name = skillEffect.name
        }
        if self.isBuff != skillEffect.isBuff {
            self.isBuff = skillEffect.isBuff
        }
        if self.imageFilename != skillEffect.imageFilename {
            self.imageFilename = skillEffect.imageFilename
        }
    }
    
    static func insertOrUpdate(skillEffect: SkillEffectData,
                               docInfo: SummonerDocumentInfo) {
        var skill: SkillEffect!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<SkillEffect> = SkillEffect.fetchRequest()

            let predicate = NSPredicate(format: "id == %i", skillEffect.id)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = SkillEffect(context: docInfo.taskContext)
                skill.update(skillEffect)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillEffect)
             }
        }
    }
    
    static func batchUpdate(from skillEffectData: [SkillEffectData],
                            docInfo: SummonerDocumentInfo) {
        for skillEffect in skillEffectData {
            SkillEffect.insertOrUpdate(skillEffect: skillEffect, docInfo: docInfo)
        }
    }
}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
 CREATE TABLE public.bestiary_skilleffect
 (
     id integer NOT NULL DEFAULT nextval('bestiary_skilleffect_id_seq'::regclass),
     is_buff boolean NOT NULL,
     name character varying(40) COLLATE pg_catalog."default" NOT NULL,
     description text COLLATE pg_catalog."default" NOT NULL,
     icon_filename character varying(100) COLLATE pg_catalog."default" NOT NULL,
     CONSTRAINT bestiary_skilleffect_pkey PRIMARY KEY (id)
 )


 */
