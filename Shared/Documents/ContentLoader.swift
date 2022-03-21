//
//  ContentLoader.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/21.
//

import Foundation

class BestiaryLoader {
	enum Error: Swift.Error {
		case fileNotFound(name: String)
		case fileDecodingFailed(name: String, Swift.Error)
	}

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
