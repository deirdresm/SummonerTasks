//
//  Team.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/1/20.
//

import Foundation
import CoreData

// Note that public.herders_team_roster is a many-to-many join table and thus not directly
// represented in the data model (because there are no extra attributes where that would
// need to happen), but they may need to be accounted for when decoding a JSON file.

// MARK: - Core Data

// MARK: - Original SQL Table Definition

/*
 CREATE TABLE public.herders_team
 (
     id uuid NOT NULL,
     name character varying(30) COLLATE pg_catalog."default" NOT NULL,
     favorite boolean NOT NULL,
     description text COLLATE pg_catalog."default",
     group_id uuid,
     leader_id uuid,
     level_id integer,
     owner_id integer,
     CONSTRAINT herders_team_pkey PRIMARY KEY (id),
     CONSTRAINT herders_team_group_id_15b49dee_fk_herders_teamgroup_id FOREIGN KEY (group_id)
         REFERENCES public.herders_teamgroup (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_team_leader_id_e205e8ce_fk_herders_monsterinstance_id FOREIGN KEY (leader_id)
         REFERENCES public.herders_monsterinstance (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_team_level_id_02e9d5c9_fk_bestiary_level_id FOREIGN KEY (level_id)
         REFERENCES public.bestiary_level (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_team_owner_id_725b5045_fk_herders_summoner_id FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )
 WITH (
     OIDS = FALSE
 )
 TABLESPACE pg_default;

 ALTER TABLE public.herders_team
     OWNER to swarfarmer_dev;

 -- Index: herders_team_group_id_15b49dee

 -- DROP INDEX public.herders_team_group_id_15b49dee;

 CREATE INDEX herders_team_group_id_15b49dee
     ON public.herders_team USING btree
     (group_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: herders_team_leader_id_e205e8ce

 -- DROP INDEX public.herders_team_leader_id_e205e8ce;

 CREATE INDEX herders_team_leader_id_e205e8ce
     ON public.herders_team USING btree
     (leader_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: herders_team_level_id_02e9d5c9

 -- DROP INDEX public.herders_team_level_id_02e9d5c9;

 CREATE INDEX herders_team_level_id_02e9d5c9
     ON public.herders_team USING btree
     (level_id ASC NULLS LAST)
     TABLESPACE pg_default;


 -- Index: herders_team_owner_id_725b5045

 -- DROP INDEX public.herders_team_owner_id_725b5045;

 CREATE INDEX herders_team_owner_id_725b5045
     ON public.herders_team USING btree
     (owner_id ASC NULLS LAST)
     TABLESPACE pg_default;
 */

/* CREATE TABLE public.herders_team_roster
 (
     id integer NOT NULL DEFAULT nextval('herders_team_roster_id_seq'::regclass),
     team_id uuid NOT NULL,
     monsterinstance_id uuid NOT NULL,
     CONSTRAINT herders_team_roster_pkey PRIMARY KEY (id),
     CONSTRAINT herders_team_roster_team_id_monsterinstance_id_8a07d82f_uniq UNIQUE (team_id, monsterinstance_id),
     CONSTRAINT herders_team_roster_monsterinstance_id_82e8c6e1_fk_herders_m FOREIGN KEY (monsterinstance_id)
         REFERENCES public.herders_monsterinstance (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_team_roster_team_id_e9cde554_fk_herders_team_id FOREIGN KEY (team_id)
         REFERENCES public.herders_team (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )
 WITH (
     OIDS = FALSE
 )

*/
