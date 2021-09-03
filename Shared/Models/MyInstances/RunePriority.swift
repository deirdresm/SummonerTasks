//
//  RunePriority.swift
//  RunePriority
//
//  Created by Deirdre Saoirse Moen on 8/16/21.
//

import Foundation
import CoreData

@objc(RunePriority)
public class RunePriority: NSManagedObject, Comparable, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case attribute
        case amount
        case area
        case element
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        id = try container.decode(Int64.self, forKey: .id)
        attribute = try container.decode(Int64.self, forKey: .attribute)
        amount = try container.decode(Int64.self, forKey: .amount)
        area = try container.decode(Int64.self, forKey: .area)
        element = try container.decode(String.self, forKey: .element)
    }

    public static func < (lhs: RunePriority, rhs: RunePriority) -> Bool {
        lhs.id < rhs.id
    }

}
