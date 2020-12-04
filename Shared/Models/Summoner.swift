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

extension Summoner {
    static let classNameTransformerName = NSValueTransformerName(rawValue: "JSONValueTransformer")

    
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
