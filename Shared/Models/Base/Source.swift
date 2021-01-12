//
//  BestiarySource.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

extension Source: Comparable {
    func update(_ sourceData: SourceData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != sourceData.id {
            self.id = Int64(sourceData.id)
        }
        if self.name != sourceData.name {
            self.name = sourceData.name
        }
        if self.c2uDescription != sourceData.description {
            self.c2uDescription = sourceData.description
        }
        if self.imageFilename != sourceData.imageFilename {
            self.imageFilename = sourceData.imageFilename
        }
        if self.isFarmable != sourceData.farmableSource {
            self.isFarmable = sourceData.farmableSource
        }
        if self.metaOrder != sourceData.metaOrder {
            self.metaOrder = sourceData.metaOrder
        }
    }
    
    static func insertOrUpdate(sourceData: SourceData,
                               docInfo: SummonerDocumentInfo) {
        var source: Source!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<Source> = Source.fetchRequest()

            request.predicate = NSPredicate(format: "id == %i", sourceData.id)
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                source = Source(context: docInfo.taskContext)
                source.update(sourceData)
             } else {
                // update existing
                source = results?.first
                source.update(sourceData)
             }
        }
    }
    
    static func batchUpdate(from sources: [SourceData],
                            docInfo: SummonerDocumentInfo) {
        for source in sources {
            Source.insertOrUpdate(sourceData: source, docInfo: docInfo)
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
