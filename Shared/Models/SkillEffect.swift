//
//  SkillEffect.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

// MARK: - Core Data

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
