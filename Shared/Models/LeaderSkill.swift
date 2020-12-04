//
//  LeaderSkill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData


// MARK: - Core Data

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_leaderskill
    (
        id integer NOT NULL DEFAULT nextval('bestiary_leaderskill_id_seq'::regclass),
        attribute integer NOT NULL,
        amount integer NOT NULL,
        area integer NOT NULL,
        element character varying(6) COLLATE pg_catalog."default",
        CONSTRAINT bestiary_leaderskill_pkey PRIMARY KEY (id)
    )
*/
