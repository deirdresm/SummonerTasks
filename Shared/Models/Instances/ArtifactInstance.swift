//
//  ArtifactInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data

// MARK: - Original SQL Table Definition


/*
    CREATE TABLE public.herders_artifactinstance
    (
     slot integer NOT NULL,
     element character varying(6) COLLATE pg_catalog."default",
     archetype character varying(10) COLLATE pg_catalog."default",
     quality integer NOT NULL,
     level integer NOT NULL,
     original_quality integer NOT NULL,
     main_stat integer NOT NULL,
     main_stat_value integer NOT NULL,
     effects integer[] NOT NULL,
     effects_value double precision[] NOT NULL,
     effects_upgrade_count integer[] NOT NULL,
     effects_reroll_count integer[] NOT NULL,
     id uuid NOT NULL,
     com2us_id bigint,
     assigned_to_id uuid,
     owner_id integer NOT NULL,
     efficiency double precision NOT NULL,
     max_efficiency double precision NOT NULL,
     CONSTRAINT herders_artifactinstance_pkey PRIMARY KEY (id),
     CONSTRAINT herders_artifactinst_assigned_to_id_05b980a1_fk_herders_m FOREIGN KEY (assigned_to_id)
         REFERENCES public.herders_monsterinstance (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_artifactinst_owner_id_2802668f_fk_herders_s FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/