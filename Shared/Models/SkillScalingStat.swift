//
//  SkillScalingStat.swift
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
 CREATE TABLE public.bestiary_skill_scaling_stats
 (
     id integer NOT NULL DEFAULT nextval('bestiary_skill_scaling_stats_id_seq'::regclass),
     skill_id integer NOT NULL,
     scalingstat_id integer NOT NULL,
     CONSTRAINT bestiary_skill_scaling_stats_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_skill_scaling_s_skill_id_scalingstat_id_26c92422_uniq UNIQUE (skill_id, scalingstat_id),
     CONSTRAINT bestiary_skill_scali_scalingstat_id_8218a512_fk_bestiary_ FOREIGN KEY (scalingstat_id)
         REFERENCES public.bestiary_scalingstat (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_skill_scali_skill_id_0cc73ebc_fk_bestiary_ FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )


 */
