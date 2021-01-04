//
//  SourceData.swift
//  Testing123
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

public struct SourceData: JsonArray {
    
    static var items = [SourceData]()
    
    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case name
        case description
        case imageFilename = "icon_filename"
        case farmableSource
        case metaOrder = "meta_order"
    }
    
    let id:             Int64
    let name:           String
    let description:    String
    let imageFilename:  String
    var farmableSource: Bool = false
    let metaOrder:      Int64

    public init(source: JSON, pk: Int64) {
        id = source.pk.int
        name = source.fields.name.string
        description = source.fields.description.string
        imageFilename = source.fields.icon_filename.string
        farmableSource = source.fields.farmable_source.bool
        metaOrder = source.fields.meta_order.int
    }
    
    static func saveToCoreData(_ taskContext: NSManagedObjectContext) {
        
        taskContext.perform {
            Source.batchUpdate(from: SourceData.items,
                                 context: taskContext)
            do {
                try taskContext.save()
            } catch {
                print("could not save context")
            }
        }
    }
}
