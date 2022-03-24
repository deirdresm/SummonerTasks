//
//  FusionData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public struct FusionData: JsonArray {

	static var items = [FusionData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case product
		case cost
		case metaOrder = "meta_order"
		case ingredients
	}

	let id:             Int64
	let product:        Int64
	let cost:           Int64
	let metaOrder:      Int64
	var ingredients:    [Int64]

	public init(fusion: JSON, pk: Int64) {
		id = fusion.pk.int
		product = fusion.product.int
		cost = fusion.cost.int
		metaOrder = fusion.fields.meta_order.int

		let jsonArr = fusion.fields.ingredients.value

		// TODO: figure out why here, of all places, it's
		// converting to [Int64] without having to kick it
		ingredients = jsonArr as! [Int64]
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			Fusion.batchUpdate(from: FusionData.items,
							   docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}


/*
 {
   "model": "bestiary.fusion",
   "pk": 1,
   "fields": {
	 "product": 646,
	 "cost": 500000,
	 "meta_order": 1,
	 "ingredients": [
	   534,
	   236,
	   336,
	   603
	 ]
   }
 },

 */
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
