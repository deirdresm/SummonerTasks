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
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.skillId = try container.decode(Int64.self, forKey: .skill)
		if let skill = Skill.findById(self.skillId, context: context) {
			self.skill = skill
		}
		self.level = try container.decode(Int64.self, forKey: .level)

		let effect = try container.decode(Int64.self, forKey: .effect)
		if let skilleffect = SkillEffect.findById(effect, context: context) {
			self.effect = skilleffect
		}
		self.amount = try container.decode(Int64.self, forKey: .amount)
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
