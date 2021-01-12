//
//  Summoner.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData
import Cocoa

// MARK: - Core Data

extension Summoner: CoreDataUtilityMutable {
    static let classNameTransformerName = NSValueTransformerName(rawValue: "JSONValueTransformer")
    
    static func findById(_ summonerId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> Summoner? {
        
        let request : NSFetchRequest<Summoner> = Summoner.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", summonerId)
        
        if let results = try? context.fetch(request) {
        
            if let summoner = results.first {
                return summoner
            }
        }
        return nil
    }
    
    func update<T: JsonArrayMutable>(from: T, docInfo: inout SummonerDocumentInfo) {
        let summonerData = from as! SummonerData
        
        // don't dirty the record if you don't have to
        
        if self.name != summonerData.name {
            self.name = summonerData.name
        }
        if self.id != summonerData.id {
            self.id = summonerData.id
        }
        if self.lastUpdate != summonerData.lastUpdate {
            self.lastUpdate = summonerData.lastUpdate
        }
    }
    
    static func insertOrUpdate<T: JsonArrayMutable>(from: T,
                               docInfo: inout SummonerDocumentInfo) {
        let summonerData = from as! SummonerData
        let summoner: Summoner = Summoner.findById(summonerData.id) ??
            Summoner(context: docInfo.taskContext)
        
        summoner.update(from: summonerData, docInfo: &docInfo)
    }
    
    static func batchUpdate<T: JsonArrayMutable>(from: [T],
                            docInfo: inout SummonerDocumentInfo) {
        let summoners = from as! [SummonerData]
        for summoner in summoners {
            Summoner.insertOrUpdate(from: summoner, docInfo: &docInfo)
        }
    }
}

@objc(JSONValueTransformer)
public final class JSONValueTransformer: ValueTransformer {
    override public class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override public func transformedValue(_ value: Any?) -> Any? {
        return (value as! NSColor).className //TODO: fix to JSON
    }
}


/*
 "wizard_info": {
   "wizard_id": 1234567,
   "wizard_name": "namegoeshere",
   "wizard_mana": 417401,
   "wizard_crystal": 4423,
   "wizard_crystal_paid": 4322,
   "wizard_last_login": "2020-09-23 04:43:55",
   "wizard_last_country": "US",
   "wizard_last_lang": "en",
   "wizard_level": 50,
   "experience": 3800000,
   "wizard_energy": 162,
   "energy_max": 200,
   "energy_per_min": 0.26,
   "next_energy_gain": 176,
   "arena_energy": 6,
   "arena_energy_max": 10,
   "arena_energy_next_gain": 1265,
   "unit_slots": {
     "number": 120
   },
*/



// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.herders_summoner
    (
     id integer NOT NULL DEFAULT nextval('herders_summoner_id_seq'::regclass),
     summoner_name character varying(256) COLLATE pg_catalog."default",
     com2us_id bigint,
     server integer,
     public boolean NOT NULL,
     timezone character varying(63) COLLATE pg_catalog."default" NOT NULL,
     notes text COLLATE pg_catalog."default",
     preferences jsonb NOT NULL,
     last_update timestamp with time zone NOT NULL,
     user_id integer NOT NULL,
     CONSTRAINT herders_summoner_pkey PRIMARY KEY (id),
     CONSTRAINT herders_summoner_user_id_key UNIQUE (user_id),
     CONSTRAINT herders_summoner_user_id_aacda62d_fk_auth_user_id FOREIGN KEY (user_id)
         REFERENCES public.auth_user (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
    WITH (
     OIDS = FALSE
    )
*/
