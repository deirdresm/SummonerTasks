//
//  SkillUpgrade.swift
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
     CREATE TABLE public.bestiary_skillupgrade
     (
         id integer NOT NULL DEFAULT nextval('bestiary_skillupgrade_id_seq'::regclass),
         level integer NOT NULL,
         effect integer NOT NULL,
         amount integer NOT NULL,
         skill_id integer NOT NULL,
         CONSTRAINT bestiary_skillupgrade_pkey PRIMARY KEY (id),
         CONSTRAINT bestiary_skillupgrade_skill_id_1b1822ee_fk_bestiary_skill_id FOREIGN KEY (skill_id)
             REFERENCES public.bestiary_skill (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED
     )
 */
