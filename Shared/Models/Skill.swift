//
//  Skill.swift
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
    CREATE TABLE public.bestiary_skill
    (
     id integer NOT NULL DEFAULT nextval('bestiary_skill_id_seq'::regclass),
     name character varying(60) COLLATE pg_catalog."default" NOT NULL,
     com2us_id integer,
     description text COLLATE pg_catalog."default" NOT NULL,
     slot integer NOT NULL,
     cooltime integer,
     hits integer NOT NULL,
     aoe boolean NOT NULL,
     passive boolean NOT NULL,
     max_level integer NOT NULL,
     level_progress_description text COLLATE pg_catalog."default",
     icon_filename character varying(100) COLLATE pg_catalog."default",
     multiplier_formula text COLLATE pg_catalog."default",
     multiplier_formula_raw character varying(150) COLLATE pg_catalog."default",
     CONSTRAINT bestiary_skill_pkey PRIMARY KEY (id)
    )
*/
