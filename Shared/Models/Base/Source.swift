//
//  BestiarySource.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

@objc(Source)
public class Source: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case name
		case c2uDescription = "description"
		case imageFilename = "icon_filename"
		case isFarmable = "farmable_source"
		case metaOrder = "meta_order"
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
		self.imageFilename = try container.decode(String.self, forKey: .imageFilename)
		self.name = try container.decode(String.self, forKey: .name)
		self.isFarmable = try container.decode(Bool.self, forKey: .isFarmable)
		self.metaOrder = try container.decode(Int64.self, forKey: .metaOrder)
	}

    static func findById(_ id: Int64,
                    context: NSManagedObjectContext) -> Source? {
        
        let request : NSFetchRequest<Source> = Source.fetchRequest()

        request.predicate = NSPredicate(format: "id == %i", id)
        
        let results = try? context.fetch(request)
        
        if let _ = results?.count {
            return(results?.first)
        } else {
            return(nil)
        }
    }

//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        let sourceData = from as! SourceData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != sourceData.id {
//            self.id = Int64(sourceData.id)
//        }
//        if self.name != sourceData.name {
//            self.name = sourceData.name
//        }
//        if self.c2uDescription != sourceData.description {
//            self.c2uDescription = sourceData.description
//        }
//        if self.imageFilename != sourceData.imageFilename {
//            self.imageFilename = sourceData.imageFilename
//        }
//        if self.isFarmable != sourceData.farmableSource {
//            self.isFarmable = sourceData.farmableSource
//        }
//        if self.metaOrder != sourceData.metaOrder {
//            self.metaOrder = sourceData.metaOrder
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        let sourceData = from as! SourceData
//        let source: Source = Source.findById(sourceData.id, context: docInfo.taskContext) ??
//            Source(context: docInfo.taskContext)
//        
//        source.update(from: sourceData, docInfo: docInfo)
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let sources = from as! [SourceData]
//        for source in sources {
//            Source.insertOrUpdate(from: source, docInfo: docInfo)
//        }
//    }
//
    public static func < (lhs: Source, rhs: Source) -> Bool {
        lhs.metaOrder < rhs.metaOrder
    }
}

/*
     CREATE TABLE public.bestiary_source
     (
         id integer NOT NULL DEFAULT nextval('bestiary_source_id_seq'::regclass),
         name character varying(100) COLLATE pg_catalog."default" NOT NULL,
         description text COLLATE pg_catalog."default",
         icon_filename character varying(100) COLLATE pg_catalog."default",
         farmable_source boolean NOT NULL,
         meta_order integer NOT NULL,
         CONSTRAINT bestiary_source_pkey PRIMARY KEY (id)
     )
*/
