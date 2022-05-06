//
//  Fusion.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data Fusion

@objc(Fusion)
public class Fusion: NSManagedObject, Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case product
		case cost
		case metaOrder = "meta_order"
		case ingredients
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "Fusion", in: context) else { fatalError("Could not get entity [for Fusion]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		self.product = (fields["product"]).orInt
		self.metaOrder = (fields["meta_order"]).orInt

		if let monster = Monster.findById(self.product, context: context) {
			self.fusionProduct = monster
		}

		self.cost = (fields["cost"]).orInt

		var finalIngredients: Set<Monster> = []

		let tempIngredients = fields["ingredients"].orIntArray
		for ingredient in tempIngredients {
			if let monster = Monster.findById(ingredient, context: context) {
				finalIngredients.insert(monster)
			}
		}
		self.fusionIngredients = finalIngredients as NSSet
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

	static func findById(_ fusionId: Int64,
                                 context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> Fusion? {
        
        let request : NSFetchRequest<Fusion> = Fusion.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", fusionId)
        
        if let results = try? context.fetch(request) {
        
            if let fusion = results.first {
                return fusion
            }
        }
        return nil
    }
}


// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_fusion
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
*/
