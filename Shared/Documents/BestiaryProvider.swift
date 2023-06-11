//
//  BestiaryProvider.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 4/1/22.
//

import CoreData
import OSLog

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

public class BestiaryProvider {
	private let inMemory: Bool
	var persistence: Persistence
	public var taskContext: NSManagedObjectContext

	var decoder: JSONDecoder

	// bestiary file results
	var items: [BestiaryItem]

	let logger = Logger(subsystem: "net.deirdre.SummonerTasks", category: "bestiaryprovider")

	/// A shared bestiary provider for use within the main app bundle.
	static let shared = BestiaryProvider()

	private init(inMemory: Bool = false) {
		var data: Data
		var filePath: URL
		let url: URL
		var json: String

		self.inMemory = inMemory

		if !inMemory {
			self.persistence = Persistence.shared
			self.taskContext = persistence.newTaskContext()
			do {
				filePath = Bundle.main.url(forResource: "bestiary_data", withExtension: "json")!
				data = try Data(contentsOf: filePath)

				self.logger.debug("have data of \(data.count) bytes")
			}
			catch {
				fatalError("Couldn't load unzip path from main bundle:\n\(error)")
			}
		} else {	// in memory, so for previews or testing
			self.persistence = Persistence.preview
			self.taskContext = persistence.newTaskContext()

			self.logger.debug("reading sample bestiary data")
			filePath = Bundle.main.url(forResource: "building-mini", withExtension: "json")!
			data = try! Data(contentsOf: filePath)

		}

		self.logger.debug("starting bestiary wrapper parsing")
		decoder = JSONDecoder()
		decoder.userInfo[CodingUserInfoKey.managedObjectContext] = persistence.container.viewContext

		items = try! decoder.decode([BestiaryItem].self, from: data)
		try! persistence.container.viewContext.save()
	}

	enum Error: Swift.Error {
		case fileNotFound(name: String)
		case fileDecodingFailed(name: String, Swift.Error)
	}

	// TODO not yet fully implemented
	func loadBundledFile(fromFileNamed name: String) throws {
		guard let url = Bundle.main.url(
			forResource: name,
			withExtension: "json"
		) else {
			throw Error.fileNotFound(name: name)
		}

		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			try decoder.decode(BestiaryItem.self, from: data)
		} catch {
			throw Error.fileDecodingFailed(name: name, error)
		}
	}
}
