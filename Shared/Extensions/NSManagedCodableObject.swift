//
//  NSManagedCodableObject.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//

import Foundation
import CoreData

protocol NSManagedCodableObject: NSManagedObject, Codable {

}

extension NSManagedObject {
	static func findById<T: NSManagedObject>(_ id: Int64,
					context: NSManagedObjectContext,
					predicateField: String = "com2usId") -> T? {

		let request: NSFetchRequest<NSFetchRequestResult> = self.fetchRequest()

		request.predicate = NSPredicate(format: "\(predicateField) == %i", id)

		let results = try? context.fetch(request)
		let returnVal = (results?.first) as? T

		return(returnVal)
	}

}
