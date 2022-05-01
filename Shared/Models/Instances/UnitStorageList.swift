//
//  UnitStorageList.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 4/16/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unitStorageList = try UnitStorageList(json)

import Foundation

// MARK: - UnitStorageList
class UnitStorageList: Codable {
	var unitStorageList: [UnitStorageListElement]

	enum CodingKeys: String, CodingKey {
		case unitStorageList = "unit_storage_list"
	}

	init(unitStorageList: [UnitStorageListElement]) {
		self.unitStorageList = unitStorageList
	}
}

// MARK: UnitStorageList convenience initializers and mutators

extension UnitStorageList {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(UnitStorageList.self, from: data)
		self.init(unitStorageList: me.unitStorageList)
	}

	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		unitStorageList: [UnitStorageListElement]? = nil
	) -> UnitStorageList {
		return UnitStorageList(
			unitStorageList: unitStorageList ?? self.unitStorageList
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// UnitStorageListElement.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unitStorageListElement = try UnitStorageListElement(json)

import Foundation

// MARK: - UnitStorageListElement
class UnitStorageListElement: Codable {
	var unitMasterID, unitStorageListClass, quantity: Int

	enum CodingKeys: String, CodingKey {
		case unitMasterID = "unit_master_id"
		case unitStorageListClass = "class"
		case quantity
	}

	init(unitMasterID: Int, unitStorageListClass: Int, quantity: Int) {
		self.unitMasterID = unitMasterID
		self.unitStorageListClass = unitStorageListClass
		self.quantity = quantity
	}
}

// MARK: UnitStorageListElement convenience initializers and mutators

extension UnitStorageListElement {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(UnitStorageListElement.self, from: data)
		self.init(unitMasterID: me.unitMasterID, unitStorageListClass: me.unitStorageListClass, quantity: me.quantity)
	}

	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		unitMasterID: Int? = nil,
		unitStorageListClass: Int? = nil,
		quantity: Int? = nil
	) -> UnitStorageListElement {
		return UnitStorageListElement(
			unitMasterID: unitMasterID ?? self.unitMasterID,
			unitStorageListClass: unitStorageListClass ?? self.unitStorageListClass,
			quantity: quantity ?? self.quantity
		)
	}

	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}
