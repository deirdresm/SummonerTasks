//
//  GameItemData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public struct GameItemData: JsonArray {
    
    static var items = [GameItemData]()
    
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
    
    let id:             Int64
    let name:           String
    let com2usId:       Int64
    let c2uDescription: String
    let imageFilename:  String
    let category:       Int64
    let slug:           String
    let sellValue:      Int64

    public init(gameItem: JSON, pk: Int64) {
        id = gameItem.pk.int
        name = gameItem.fields.name.string
        com2usId = gameItem.fields.com2us_id.int
        c2uDescription = gameItem.fields.description.string
        imageFilename = gameItem.fields.icon.string
        category = gameItem.fields.category.int
        slug = gameItem.fields.slug.string
        sellValue = gameItem.fields.sellValue.int
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            GameItem.batchUpdate(from: GameItemData.items,
                                 docInfo: docInfo)
            do {
                try docInfo.taskContext.save()
            } catch {
                print("could not save context")
            }
        }
    }
}
