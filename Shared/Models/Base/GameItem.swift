//
//  GameItem.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

@objc(GameItem)
public class GameItem: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case com2usId = "com2us_id"
		case name
		case c2uDescription = "description"
		case imageFilename = "icon"
		case category
		case slug
		case sellValue = "sell_value"
	}

	/// Required init for Decodable conformance
	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.com2usId = try container.decode(Int64.self, forKey: .com2usId)
		self.name = try container.decode(String.self, forKey: .name)
		self.c2uDescription = try container.decode(String.self, forKey: .c2uDescription)
		self.category = try container.decode(Int64.self, forKey: .category)
		self.imageFilename = try container.decode(String.self, forKey: .imageFilename)
		self.sellValue = try container.decode(Int64.self, forKey: .sellValue)
		self.slug = try container.decode(String.self, forKey: .slug)
	}
}

extension GameItem {
	static func findById(_ gameItemId: Int64,
                         context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> GameItem? {
        
        let request : NSFetchRequest<GameItem> = GameItem.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", gameItemId)
        
        if let results = try? context.fetch(request) {
        
            if let gameItem = results.first {
                return gameItem
            }
        }
        return nil
    }

//    static func findOrCreate(_ id: Int64,
//                        context: NSManagedObjectContext) -> GameItem {
//        if let gameItem = GameItem.findById(id, context: context) {
//            return gameItem
//        }
//        let gameItem = GameItem(context: context)
//        gameItem.id = id
//        return gameItem
//    }
//
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        
//        let gameItemData = from as! GameItemData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != gameItemData.id {
//            self.id = Int64(gameItemData.id)
//        }
//        if self.name != gameItemData.name {
//            self.name = gameItemData.name
//        }
//        if self.com2usId != gameItemData.com2usId {
//            self.com2usId = Int64(gameItemData.com2usId)
//        }
//        if self.c2uDescription != gameItemData.c2uDescription {
//            self.c2uDescription = gameItemData.c2uDescription
//        }
//        if self.imageFilename != gameItemData.imageFilename {
//            self.imageFilename = gameItemData.imageFilename
//        }
//        if self.category != gameItemData.category {
//            self.category = gameItemData.category
//        }
//        if self.slug != gameItemData.slug {
//            self.slug = gameItemData.slug
//        }
//        if self.sellValue != gameItemData.sellValue {
//            self.sellValue = gameItemData.sellValue
//        }
//    }
//
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        docInfo.taskContext.performAndWait {
//            let gameItemData = from as! GameItemData
//            let gameItem = GameItem.findOrCreate(gameItemData.com2usId, context: docInfo.taskContext)
//            gameItem.update(from: gameItemData, docInfo: docInfo)
//        }
//    }
//
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        let gameItems = from as! [GameItemData]
//        for gameItem in gameItems {
//            GameItem.insertOrUpdate(from: gameItem, docInfo: docInfo)
//        }
//    }
//
}

/*
 CREATE TABLE public.bestiary_gameitem
 (
     id integer NOT NULL DEFAULT nextval('bestiary_gameitem_id_seq'::regclass),
     com2us_id integer NOT NULL,
     category integer NOT NULL,
     name character varying(200) COLLATE pg_catalog."default" NOT NULL,
     icon character varying(200) COLLATE pg_catalog."default",
     description text COLLATE pg_catalog."default" NOT NULL,
     sell_value integer,
     slug character varying(200) COLLATE pg_catalog."default" NOT NULL,
     CONSTRAINT bestiary_gameitem_pkey PRIMARY KEY (id),
     CONSTRAINT bestiary_gameitem_com2us_id_category_f17d2522_uniq UNIQUE (com2us_id, category)
 )


 */
