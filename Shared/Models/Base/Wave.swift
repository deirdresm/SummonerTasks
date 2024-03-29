//
//  Wave.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//


import Foundation
import CoreData

@objc(Wave)
public class Wave: NSManagedObject, Decodable {
//extension Wave: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case levelId = "level"
		case order
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext]  as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "Wave", in: context) else { fatalError("Could not get entity [for Wave]") }

		// init self
		self.init(entity: entity, insertInto: context)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)

		// and start decoding
		self.levelId = (fields["level"]).orInt
		self.order = (fields["order"]).orInt16
	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}
}
