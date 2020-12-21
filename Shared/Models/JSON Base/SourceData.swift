//
//  SourceData.swift
//  Testing123
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation

public struct SourceData {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case name
        case description
        case imageFilename = "icon_filename"
        case farmableSource
        case com2usId = "meta_order"
    }
    
    let id:             Int64
    let name:           String
    let description:    String
    let imageFilename:  String
    var farmableSource: Bool = false
    let com2usId:       Int64

    public init(source: JSON, pk: Int64) {
        id = source.pk.int
        name = source.fields.name.string
        description = source.fields.description.string
        imageFilename = source.fields.icon_filename.string
        farmableSource = source.fields.farmable_source.bool
        com2usId = source.fields.com2us_id.int
    }
}
