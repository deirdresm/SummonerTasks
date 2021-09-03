//
//  MonsterSkill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data

// intermediary join, may not be needed to implement

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_monster_skills
    (
     id integer NOT NULL DEFAULT nextval('bestiary_monster_skills_id_seq'::regclass),
     monster_id integer NOT NULL,
     skill_id integer NOT NULL,
     CONSTRAINT bestiary_monster_skills_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_monster_skills_monster_id_skill_id_fccab7c9_uniq UNIQUE (monster_id, skill_id),
     CONSTRAINT bestiary_monster_ski_monster_id_7bf71536_fk_bestiary_ FOREIGN KEY (monster_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_monster_skills_skill_id_3f62eb14_fk_bestiary_skill_id FOREIGN KEY (skill_id)
         REFERENCES public.bestiary_skill (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
