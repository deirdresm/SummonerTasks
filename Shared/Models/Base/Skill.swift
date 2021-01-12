//
//  Skill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

extension Skill: Comparable {
    
    convenience init(skillData: SkillData) {
        self.init()
        update(skillData)
    }
    
    func update(_ skillData: SkillData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != skillData.id {
            self.id = Int64(skillData.id)
        }
        if self.name != skillData.name {
            self.name = skillData.name
        }
        if self.com2usId != skillData.com2usId {
            self.com2usId = skillData.com2usId
        }
        if self.c2uDescription != skillData.c2uDescription {
            self.c2uDescription = skillData.c2uDescription
        }
        if self.slot != skillData.slot {
            self.slot = skillData.slot
        }
        if self.cooltime != skillData.cooltime {
            self.cooltime = skillData.cooltime ?? 0
        }
        if self.hits != skillData.hits {
            self.hits = skillData.hits
        }
        if self.aoe != skillData.aoe {
            self.aoe = skillData.aoe
        }
        if self.passive != skillData.passive {
            self.passive = skillData.passive
        }
        if self.maxLevel != skillData.maxLevel {
            self.maxLevel = skillData.maxLevel
        }
        if self.levelProgressDescription != skillData.levelProgressDescription {
            self.levelProgressDescription = skillData.levelProgressDescription
        }
        if self.imageFilename != skillData.imageFilename {
            self.imageFilename = skillData.imageFilename
        }
        if self.multiplierFormula != skillData.multiplierFormula {
            self.multiplierFormula = skillData.multiplierFormula
        }
        if self.multiplierFormulaRaw != skillData.multiplierFormulaRaw {
            self.multiplierFormulaRaw = skillData.multiplierFormulaRaw
        }
        if self.scalingStatsIds != skillData.scalingStats {
            self.scalingStatsIds = skillData.scalingStats
        }
        if self.skillEffect != skillData.skillEffect {
            self.skillEffect = skillData.skillEffect
        }
    }
    
    static func insertOrUpdate(skillData: SkillData,
                               docInfo: SummonerDocumentInfo) {
        var skill: Skill!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<Skill> = Skill.fetchRequest()

            let predicate = NSPredicate(format: "com2usId == %i", skillData.com2usId)

            request.predicate = predicate
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                skill = Skill(context: docInfo.taskContext)
                skill.update(skillData)
             } else {
                // update existing
                skill = results?.first
                skill.update(skillData)
             }
        }
    }
    
    static func batchUpdate(from skills: [SkillData],
                            docInfo: SummonerDocumentInfo) {
        for skill in skills {
            Skill.insertOrUpdate(skillData: skill, docInfo: docInfo)
        }
    }

    public var skillUpgradesSorted: [SkillUpgrade] {
        let set = upgrades as? Set<SkillUpgrade> ?? []
        return set.sorted {
            $0.level < $1.level
        }
    }

    // MARK: - Comparable conformance
    
    public static func < (lhs: Skill, rhs: Skill) -> Bool {
        lhs.slot < rhs.slot
    }
}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_skill
    (
     id integer NOT NULL DEFAULT nextval('bestiary_skill_id_seq'::regclass),
     name character varying(60) COLLATE pg_catalog."default" NOT NULL,
     com2us_id integer,
     description text COLLATE pg_catalog."default" NOT NULL,
     slot integer NOT NULL,
     cooltime integer,
     hits integer NOT NULL,
     aoe boolean NOT NULL,
     passive boolean NOT NULL,
     max_level integer NOT NULL,
     level_progress_description text COLLATE pg_catalog."default",
     icon_filename character varying(100) COLLATE pg_catalog."default",
     multiplier_formula text COLLATE pg_catalog."default",
     multiplier_formula_raw character varying(150) COLLATE pg_catalog."default",
     CONSTRAINT bestiary_skill_pkey PRIMARY KEY (id)
    )
*/
