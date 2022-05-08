//
//  SkillUpgrade.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data

@objc(SkillUpgrade)
public class SkillUpgrade: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skill, level, effect, amount
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "SkillUpgrade", in: context) else { fatalError("Could not get entity [for SkillUpgrade]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		// and start decoding
		self.id = (fields["id"]).orInt
		self.skillId = (fields["skill"]).orInt
		// and start decoding
		if let skill = Skill.findById(self.skillId, context: context) {
			self.skill = skill
		}
		self.level = (fields["level"]).orInt

		self.effectId = (fields["effect"]).orInt
		if let skilleffect = SkillEffect.findById(self.effectId, context: context) {
			self.effect = skilleffect
		}
		self.amount = (fields["amount"]).orInt
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

    static func findById(_ skillDataId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> SkillUpgrade? {
        
        let request : NSFetchRequest<SkillUpgrade> = SkillUpgrade.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillDataId)
        
        if let results = try? context.fetch(request) {
        
            if let skill = results.first {
                return skill
            }
        }
        return nil
    }
}


// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
     CREATE TABLE public.bestiary_skillupgrade
     (
         id integer NOT NULL DEFAULT nextval('bestiary_skillupgrade_id_seq'::regclass),
         level integer NOT NULL,
         effect integer NOT NULL,
         amount integer NOT NULL,
         skill_id integer NOT NULL,
         CONSTRAINT bestiary_skillupgrade_pkey PRIMARY KEY (id),
         CONSTRAINT bestiary_skillupgrade_skill_id_1b1822ee_fk_bestiary_skill_id FOREIGN KEY (skill_id)
             REFERENCES public.bestiary_skill (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED
     )
 */
