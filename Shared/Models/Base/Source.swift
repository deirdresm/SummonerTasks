//
//  BestiarySource.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

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
