//
//  GameItem.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/3/20.
//

import Foundation
import CoreData

extension GameItem {
    func update(_ gameItemData: GameItemData) {
        
        // don't dirty the record if you don't have to
        
        if self.id != gameItemData.id {
            self.id = Int64(gameItemData.id)
        }
        if self.name != gameItemData.name {
            self.name = gameItemData.name
        }
        if self.com2usId != gameItemData.com2usId {
            self.com2usId = Int64(gameItemData.com2usId)
        }
        if self.c2uDescription != gameItemData.c2uDescription {
            self.c2uDescription = gameItemData.c2uDescription
        }
        if self.imageFilename != gameItemData.imageFilename {
            self.imageFilename = gameItemData.imageFilename
        }
        if self.category != gameItemData.category {
            self.category = gameItemData.category
        }
        if self.slug != gameItemData.slug {
            self.slug = gameItemData.slug
        }
        if self.sellValue != gameItemData.sellValue {
            self.sellValue = gameItemData.sellValue
        }
    }
    
    static func insertOrUpdate(gameItemData: GameItemData,
                               docInfo: SummonerDocumentInfo) {
        var gameItem: GameItem!
        
        docInfo.taskContext.performAndWait {
            let request : NSFetchRequest<GameItem> = GameItem.fetchRequest()

            request.predicate = NSPredicate(format: "id == %i", gameItemData.id)
            
            let results = try? docInfo.taskContext.fetch(request)

            if results?.count == 0 {
                // insert new
                gameItem = GameItem(context: docInfo.taskContext)
                gameItem.update(gameItemData)
             } else {
                // update existing
                gameItem = results?.first
                gameItem.update(gameItemData)
             }
        }
    }
    
    static func batchUpdate(from gameItems: [GameItemData],
                            docInfo: SummonerDocumentInfo) {
        for gameItem in gameItems {
            GameItem.insertOrUpdate(gameItemData: gameItem, docInfo: docInfo)
        }
    }

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
