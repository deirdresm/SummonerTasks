/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import Foundation
import CoreLocation
import CoreData
import SwiftUI
import ImageIO

protocol JsonArray {
	associatedtype ItemsArray

	static var items: [ItemsArray] {get set}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo)
}

protocol JsonArrayMutable {
	associatedtype ItemsArray

	static var items: [ItemsArray] {get set}

	static func saveToCoreData(_ docInfo: inout SummonerDocumentInfo)
}

protocol CoreDataUtility
{
	func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo)
	static func insertOrUpdate<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo)
	static func batchUpdate<T: JsonArray>(from: [T], docInfo: SummonerDocumentInfo)
}

protocol CoreDataUtilityMutable
{
	func update<T: JsonArrayMutable>(from: T, docInfo: inout SummonerDocumentInfo)
	static func insertOrUpdate<T: JsonArrayMutable>(from: T, docInfo: inout SummonerDocumentInfo)
	static func batchUpdate<T: JsonArrayMutable>(from: [T], docInfo: inout SummonerDocumentInfo)
}

