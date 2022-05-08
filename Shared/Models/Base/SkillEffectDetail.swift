//
//  SkillEffectDetail.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

@objc(SkillEffectDetail)
public class SkillEffectDetail: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skill, effect, aoe
		case singleTarget = "single_target"
		case selfEffect = "self_effect"
		case chance
		case onCrit = "on_crit"
		case onDeath = "on_death"
		case random, quantity, all
		case selfHp = "self_hp"
		case targetHp = "target_hp"
		case damage, note
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "SkillEffectDetail", in: context) else { fatalError("Could not get entity [for SkillEffectDetail]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		// and start decoding
		self.id = (fields["id"]).orInt
		self.skillId = (fields["skill"]).orInt

		if let skill = Skill.findById(skillId, context: context) {
			self.skill = skill
		}
		let effect = (fields["effect"]).orInt

		if let skilleffect = SkillEffect.findById(effect, context: context) {
			self.effect = skilleffect
		}

		self.aoe = (fields["aoe"]).orFalse
		self.singleTarget = (fields["single_target"]).orFalse
		self.selfEffect = (fields["self_effect"]).orFalse
		self.chance = (fields["chance"]).orInt
		self.onCrit = (fields["on_crit"]).orFalse

		self.onDeath = (fields["onDeath"]).orFalse
		self.random = (fields["random"]).orFalse
		self.quantity = (fields["quantity"]).orInt
		self.all = (fields["all"]).orFalse
		self.selfHp = (fields["self_hp"]).orFalse
		self.targetHp = (fields["target_hp"]).orFalse
		self.damage = (fields["damage"]).orFalse
		self.note = (fields["note"]).orEmpty
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
//		self.id = pk
	}

    
    static func findById(_ skillEffectDetailId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> SkillEffectDetail? {
        
        let request : NSFetchRequest<SkillEffectDetail> = SkillEffectDetail.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillEffectDetailId)
        
        if let results = try? context.fetch(request) {
        
            if let skillEffectDetail = results.first {
                return skillEffectDetail
            }
        }
        return nil
    }
}
