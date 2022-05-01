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
		case fields
		case c2uDescription = "description"
		case imageFilename = "icon_filename"
		case isFarmable = "farmable_source"
		case metaOrder = "meta_order"
	}

	public required convenience init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "Source", in: context) else { fatalError("Could not get entity [for Source]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.id = (fields["com2us_id"]).orInt
		self.c2uDescription = (fields["description"]).orEmpty
		self.imageFilename = (fields["icon_filename"]).orEmpty
		self.name = (fields["name"]).orEmpty
		self.isFarmable = (fields["farmable_source"]).orFalse
		self.metaOrder = (fields["meta_order"]).orInt
	}

	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
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
