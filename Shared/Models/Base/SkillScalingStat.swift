//
//  SkillScalingStat.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData


// MARK: - Core Data ScalingStat

@objc(ScalingStat)
public class ScalingStat: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case c2uDescription = "description"
		case scalingDesc = "scaling_desc"
		case stat
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
		self.c2uDescription = try container.decode(String.self, forKey: .c2uDescription)
		self.scalingDesc = try container.decode(String.self, forKey: .scalingDesc)
		self.stat = try container.decode(String.self, forKey: .stat)
	}

    static func findById(_ scalingStatId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> ScalingStat? {
        
        let request : NSFetchRequest<ScalingStat> = ScalingStat.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", scalingStatId)
        
        if let results = try? context.fetch(request) {
        
            if let scalingStat = results.first {
                return scalingStat
            }
        }
        return nil
    }
    
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo)
//    {
//        let scalingStatData = from as! ScalingStatData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != scalingStatData.id {
//            self.id = Int64(scalingStatData.id)
//        }
//        if self.c2uDesc != scalingStatData.c2uDesc {
//            self.c2uDesc = scalingStatData.c2uDesc
//        }
//        if self.scalingDesc != scalingStatData.scalingDesc {
//            self.scalingDesc = scalingStatData.scalingDesc
//        }
//        if self.stat != scalingStatData.stat {
//            self.stat = scalingStatData.stat
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        docInfo.taskContext.performAndWait {
//            let scalingStatData = from as! ScalingStatData
//            let scalingStat = ScalingStat.findById(scalingStatData.id, context: docInfo.taskContext) ?? ScalingStat(context: docInfo.taskContext)
//            scalingStat.update(from: scalingStatData, docInfo: docInfo)
//        }
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let scalingStats = from as! [ScalingStatData]
//        for scalingStat in scalingStats {
//            ScalingStat.insertOrUpdate(from: scalingStat, docInfo: docInfo)
//        }
//    }
}

// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
 CREATE TABLE public.bestiary_skill_scaling_stats
 (
     id integer NOT NULL DEFAULT nextval('bestiary_skill_scaling_stats_id_seq'::regclass),
     skill_id integer NOT NULL,
     scalingstat_id integer NOT NULL,
     CONSTRAINT bestiary_skill_scaling_stats_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_skill_scaling_s_skill_id_scalingstat_id_26c92422_uniq UNIQUE (skill_id, scalingstat_id),
     CONSTRAINT bestiary_skill_scali_scalingstat_id_8218a512_fk_bestiary_ FOREIGN KEY (scalingstat_id)
         REFERENCES public.bestiary_scalingstat (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_skill_scali_skill_id_0cc73ebc_fk_bestiary_ FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )


 */
