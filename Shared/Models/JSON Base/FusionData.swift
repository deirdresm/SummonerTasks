//
//  FusionData.swift
//  SummonerImport
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
/* CREATE TABLE public.bestiary_fusion
(
    id integer NOT NULL DEFAULT nextval('bestiary_fusion_id_seq'::regclass),
    cost integer NOT NULL,
    meta_order integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT bestiary_fusion_pkey PRIMARY KEY (id),
    CONSTRAINT bestiary_fusion_product_id_47841bc7_uniq UNIQUE (product_id),
    CONSTRAINT bestiary_fusion_product_id_47841bc7_fk_bestiary_monster_id FOREIGN KEY (product_id)
        REFERENCES public.bestiary_monster (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE INITIALLY DEFERRED
)
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

