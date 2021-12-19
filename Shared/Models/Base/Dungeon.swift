//
//  Dungeon.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 10/29/21.
//

import Foundation
import CoreData

extension Dungeon: NSManagedCodableObject {
	enum CodingKeys: String, CodingKey {
		case id
		case com2UsID = "com2us_id"
		case enabled, name, slug, category, icon
	}

}
