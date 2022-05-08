////
////  HomunculusSkil.swift
////  SummonerTasks
////
////  Created by Deirdre Saoirse Moen on 12/27/20.
////

import Foundation
import CoreData


// MARK: - Core Data HomunculusSkill

@objc(HomunculusSkill)
public class HomunculusSkill: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skillId = "skill"
		case monsterIds = "monsters"
		case prerequisites
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}
		guard let entity = NSEntityDescription.entity(forEntityName: "HomunculusSkill", in: context) else { fatalError("Could not get entity [for HomunculusSkill]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.id = (fields["id"]).orInt
		self.skillId = (fields["skill"]).orInt

		if let skill = Skill.findById(self.skillId, context: context) {
			self.skill = skill
		}

		self.monsterIds = (fields["monsters"]).orIntArray
		// TODO: relationship population
		
		self.prerequisites = (fields["prerequisites"]).orIntArray
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}


	//extension HomunculusSkill: Decodable {

    static func findById(_ id: Int64,
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
}

// MARK: - Core Data HomunculusSkillcraftCost

@objc(HomunculusSkillcraftCost)
public class HomunculusSkillcraftCost: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case item
		case quantity
		case skillNum
		case skillId = "skill"
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}
		guard let entity = NSEntityDescription.entity(forEntityName: "HomunculusSkillcraftCost", in: context) else { fatalError("Could not get entity [for HomunculusSkillcraftCost]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.item = (fields["item"]).orInt
		self.quantity = (fields["quantity"]).orInt
		self.skillId = (fields["skill"]).orInt
	}
}
