//
//  Skill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

struct MultiplierFormula: Decodable {
	var stat: String
	var operation: String
	var amount: Int64

	private enum CodingKeys: String, CodingKey {
		case stat
		case operation
		case amount
	}

	public init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.stat = try container.decode(String.self, forKey: .stat)
		self.operation = try container.decode(String.self, forKey: .operation)
		self.amount = try container.decode(Int64.self, forKey: .amount)
	}

}

@objc(Skill)
public class Skill: NSManagedObject, Decodable {
//extension Skill: Comparable, Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case com2usId = "com2us_id"
		case name
		case c2uDescription = "description"
		case slot
		case cooltime
		case hits
		case aoe
		case passive
		case maxLevel
		case imageFilename
		case multiplierFormula
		case multiplierFormulaRaw
		case levelProgressDescription
		case skillEffect
		case scalingStats
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "Skill", in: context) else { fatalError("Could not get entity [for Skill]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.com2usId = try container.decode(Int64.self, forKey: .com2usId)
		self.name = try container.decode(String.self, forKey: .name)
		self.c2uDescription = try container.decode(String.self, forKey: .c2uDescription)
		self.slot = try container.decode(Int64.self, forKey: .slot)
		self.cooltime = try container.decode(Int64.self, forKey: .cooltime)
		self.hits = try container.decode(Int64.self, forKey: .hits)
		self.aoe = try container.decode(Bool.self, forKey: .aoe)
		self.passive = try container.decode(Bool.self, forKey: .passive)

		self.maxLevel = try container.decode(Int64.self, forKey: .maxLevel)
		self.imageFilename = try container.decode(String.self, forKey: .imageFilename)
		self.multiplierFormula = try container.decode(String.self, forKey: .multiplierFormula)

	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

	static func findById(_ skillDataId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
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
