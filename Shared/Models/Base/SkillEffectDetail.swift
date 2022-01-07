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

//    func update<T: JsonArray>(from: T,
//                              docInfo: SummonerDocumentInfo) {
//        let skillEffectDetail = from as! SkillEffectDetailData
//        // don't dirty the record if you don't have to
//        
//        if self.id != skillEffectDetail.id {
//            self.id = Int64(skillEffectDetail.id)
//        }
//        if self.aoe != skillEffectDetail.aoe {
//            self.aoe = skillEffectDetail.aoe
//        }
//        if self.singleTarget != skillEffectDetail.singleTarget {
//            self.singleTarget = skillEffectDetail.singleTarget
//        }
//        if self.selfEffect != skillEffectDetail.selfEffect {
//            self.selfEffect = skillEffectDetail.selfEffect
//        }
//        if self.aoe != skillEffectDetail.aoe {
//            self.aoe = skillEffectDetail.aoe
//        }
//
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        let skillEffectDetailData = from as! SkillEffectDetailData
//        let skillEffectDetail = SkillEffectDetail.findById(skillEffectDetailData.id, context: docInfo.taskContext) ??
//            SkillEffectDetail(context: docInfo.taskContext)
//        
//        skillEffectDetail.update(from: skillEffectDetailData, docInfo: docInfo)
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let skillEffectDetailData = from as! [SkillEffectDetailData]
//        for skillEffectDetail in skillEffectDetailData {
//            SkillEffectDetail.insertOrUpdate(from: skillEffectDetail, docInfo: docInfo)
//        }
//    }
//
}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_skilleffectdetail
    (
     id integer NOT NULL DEFAULT nextval('bestiary_skilleffectdetail_id_seq'::regclass),
     aoe boolean NOT NULL,
     single_target boolean NOT NULL,
     self_effect boolean NOT NULL,
     chance integer,
     on_crit boolean NOT NULL,
     on_death boolean NOT NULL,
     random boolean NOT NULL,
     quantity integer,
     "all" boolean NOT NULL,
     self_hp boolean NOT NULL,
     target_hp boolean NOT NULL,
     damage boolean NOT NULL,
     note text COLLATE pg_catalog."default",
     effect_id integer NOT NULL,
     skill_id integer NOT NULL,
     CONSTRAINT bestiary_skilleffectdetail_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_skilleffect_effect_id_fc7dd1eb_fk_bestiary_ FOREIGN KEY (effect_id)
         REFERENCES public.bestiary_skilleffect (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_skilleffect_skill_id_a8ed5058_fk_bestiary_ FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
