//
//  Monster.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// EHP = HP*(1140+(DEF*3.5))/1000

// MARK: - Core Data

extension MonsterInstance {
    
    func monsterRunesSorted() -> [RuneInstance] {
        let sortNameDescriptor = NSSortDescriptor.init(key: "slot", ascending: true)
        
        return (self.runes)?.sortedArray(using: [sortNameDescriptor]) as! [RuneInstance]
    }

}

// MARK: - JSON

/**
 A struct encapsulating the properties of a Rune. All members are
 optional in case they are missing from the data. Note: this is for the
 SWEX export data format.
 */


// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.herders_monsterinstance
    (
         id uuid NOT NULL,
         com2us_id bigint,
         created timestamp with time zone,
         stars integer NOT NULL,
         level integer NOT NULL,
         skill_1_level integer NOT NULL,
         skill_2_level integer NOT NULL,
         skill_3_level integer NOT NULL,
         skill_4_level integer NOT NULL,
         fodder boolean NOT NULL,
         in_storage boolean NOT NULL,
         ignore_for_fusion boolean NOT NULL,
         priority integer,
         notes text COLLATE pg_catalog."default",
         custom_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
         rune_hp integer NOT NULL,
         rune_attack integer NOT NULL,
         rune_defense integer NOT NULL,
         rune_speed integer NOT NULL,
         rune_crit_rate integer NOT NULL,
         rune_crit_damage integer NOT NULL,
         rune_resistance integer NOT NULL,
         rune_accuracy integer NOT NULL,
         avg_rune_efficiency double precision,
         monster_id integer NOT NULL,
         owner_id integer NOT NULL,
         default_build_id uuid,
         rta_build_id uuid,
         artifact_attack integer NOT NULL,
         artifact_defense integer NOT NULL,
         artifact_hp integer NOT NULL,
         CONSTRAINT herders_monsterinstance_pkey PRIMARY KEY (id),
         CONSTRAINT herders_monsterinsta_default_build_id_262e91d7_fk_herders_r FOREIGN KEY (default_build_id)
             REFERENCES public.herders_runebuild (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_monster_id_6d31fc16_fk_bestiary_ FOREIGN KEY (monster_id)
             REFERENCES public.bestiary_monster (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_owner_id_b6eba280_fk_herders_s FOREIGN KEY (owner_id)
             REFERENCES public.herders_summoner (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED,
         CONSTRAINT herders_monsterinsta_rta_build_id_357a7725_fk_herders_r FOREIGN KEY (rta_build_id)
             REFERENCES public.herders_runebuild (id) MATCH SIMPLE
             ON UPDATE NO ACTION
             ON DELETE NO ACTION
             DEFERRABLE INITIALLY DEFERRED
    )

*/
