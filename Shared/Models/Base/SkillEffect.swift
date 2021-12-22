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
		case com2UsId = "com2us_id"
		case enabled, name, slug, category, icon
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
		self.com2usId = try container.decode(Int64.self, forKey: .com2usId)
	}

    
    static func findById(_ skillEffectDataId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
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

//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let skillEffect = from as! SkillEffectData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != skillEffect.id {
//            self.id = Int64(skillEffect.id)
//        }
//        if self.c2uDescription != skillEffect.c2uDescription {
//            self.c2uDescription = skillEffect.c2uDescription
//        }
//        if self.name != skillEffect.name {
//            self.name = skillEffect.name
//        }
//        if self.isBuff != skillEffect.isBuff {
//            self.isBuff = skillEffect.isBuff
//        }
//        if self.imageFilename != skillEffect.imageFilename {
//            self.imageFilename = skillEffect.imageFilename
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        let skillEffectData = from as! SkillEffectData
//        let skillEffect = SkillEffect.findById(skillEffectData.id, context: docInfo.taskContext) ??
//            SkillEffect(context: docInfo.taskContext)
//        
//        skillEffect.update(from: skillEffectData, docInfo: docInfo)
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let skillEffectData = from as! [SkillEffectData]
//        for skillEffect in skillEffectData {
//            SkillEffect.insertOrUpdate(from: skillEffect, docInfo: docInfo)
//        }
//    }
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
