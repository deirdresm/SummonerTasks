//
//  Skill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

@objc(Skill)
public class Skill: NSManagedObject, Comparable, Decodable {

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

    static func findOrCreate(_ id: Int64,
                        context: NSManagedObjectContext) -> Skill {
        if let skill = Skill.findById(id, context: context) {
            return skill
        }
        let skill = Skill(context: context)
        skill.id = id
        return skill
    }


    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        let skillData = from as! SkillData
        
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
