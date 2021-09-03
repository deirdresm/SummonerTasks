//
//  TeamGroup.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData

// MARK: - Core Data

@objc(TeamGroup)
public class TeamGroup: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case attribute
        case amount
        case area
        case element
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        id = try container.decode(Int64.self, forKey: .id)
        attribute = try container.decode(Int64.self, forKey: .attribute)
        amount = try container.decode(Int64.self, forKey: .amount)
        area = try container.decode(Int64.self, forKey: .area)
        element = try container.decode(String.self, forKey: .element)
    }
}


// MARK: - JSON

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.herders_teamgroup
    (
     id uuid NOT NULL,
     name character varying(30) COLLATE pg_catalog."default" NOT NULL,
     owner_id integer NOT NULL,
     CONSTRAINT herders_teamgroup_pkey PRIMARY KEY (id),
     CONSTRAINT herders_teamgroup_owner_id_3ffbeff3_fk_herders_summoner_id FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
    WITH (
     OIDS = FALSE
    )
    TABLESPACE pg_default;

    ALTER TABLE public.herders_teamgroup
     OWNER to swarfarmer_dev;

    -- Index: herders_teamgroup_owner_id_3ffbeff3

    -- DROP INDEX public.herders_teamgroup_owner_id_3ffbeff3;

    CREATE INDEX herders_teamgroup_owner_id_3ffbeff3
     ON public.herders_teamgroup USING btree
     (owner_id ASC NULLS LAST)
     TABLESPACE pg_default;
*/
