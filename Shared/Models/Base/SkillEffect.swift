//
//  SkillEffect.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data SkillEffect

@objc(SkillEffect)
public class SkillEffect: NSManagedObject, Decodable {

	enum CodingKeys: String, CodingKey {
		case id
		case effectType = "type"
		case isBuff = "is_buff"
		case name, c2uDescription = "description"
		case imageFilename = "icon_filename"
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "SkillEffect", in: context) else { fatalError("Could not get entity [for SkillEffect]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		// and start decoding
//		self.id = try container.decode(Int64.self, forKey: .id)
		self.id = (fields["id"]).orInt
		self.effectType = (fields["type"]).orInt
		self.isBuff = (fields["is_buff"]).orFalse
		self.name = (fields["name"]).orEmpty
		self.c2uDescription = (fields["description"]).orEmpty
		self.imageFilename = (fields["icon_filename"]).orEmpty
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
//		self.id = pk
	}

    
    static func findById(_ skillEffectDataId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> SkillEffect? {
        
        let request : NSFetchRequest<SkillEffect> = SkillEffect.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillEffectDataId)
        
        if let results = try? context.fetch(request) {
        
            if let skillEffect = results.first {
                return skillEffect
            }
        }
        return nil
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
