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
		self.skill = try container.decode(Int64.self, forKey: .skill)

		let effect = try container.decode(Int64.self, forKey: .effect)
		if let skilleffect = SkillEffect.findById(effect, context: context) {
			self.effect = skilleffect
		}

		self.aoe = try container.decode(Bool.self, forKey: .aoe)
		self.singleTarget = try container.decode(Bool.self, forKey: .singleTarget)
		self.selfEffect = try container.decode(Bool.self, forKey: .selfEffect)
		self.chance = try container.decode(Int64.self, forKey: .chance)
		self.onCrit = try container.decode(Bool.self, forKey: .onCrit)
		self.onDeath = try container.decode(Bool.self, forKey: .onDeath)
		self.random = try container.decode(Bool.self, forKey: .random)
		self.quantity = try container.decode(Int64.self, forKey: .quantity)
		self.all = try container.decode(Bool.self, forKey: .all)
		self.selfHp = try container.decode(Bool.self, forKey: .selfHp)
		self.targetHp = try container.decode(Bool.self, forKey: .targetHp)
		self.damage = try container.decode(Bool.self, forKey: .damage)
		self.note = try container.decode(String.self, forKey: .note)
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
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
