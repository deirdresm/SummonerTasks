//
//  FusionIngredients.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data

// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_fusion_ingredients
    (
     id integer NOT NULL DEFAULT nextval('bestiary_fusion_ingredients_id_seq'::regclass),
     fusion_id integer NOT NULL,
     monster_id integer NOT NULL,
     CONSTRAINT bestiary_fusion_ingredients_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_fusion_ingredients_fusion_id_monster_id_c1a55d61_uniq UNIQUE (fusion_id, monster_id),
     CONSTRAINT bestiary_fusion_ingr_fusion_id_6eba06ec_fk_bestiary_ FOREIGN KEY (fusion_id)
         REFERENCES public.bestiary_fusion (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT bestiary_fusion_ingr_monster_id_a4408803_fk_bestiary_ FOREIGN KEY (monster_id)
         REFERENCES public.bestiary_monster (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
