//
//  BestiaryDocument.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/21.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine

final class BestiaryDocument: ObservableObject, FileDocument {
	static var readableContentTypes: [UTType] { [.json] }

	var text: String = ""

	/// Currently only used by testing.
	init(text: String) {
		self.text = text
	}

	required init(configuration: ReadConfiguration) throws {
		do {
			guard let data = configuration.file.regularFileContents else {
				// TODO: cover more cases
				throw CocoaError(.fileReadCorruptFile)
			}

			text = String(decoding: data, as: UTF8.self)

			guard let filename = configuration.file.filename else {
				throw CocoaError(.fileReadInvalidFileName)
			}

			guard filename.contains("bestiary_data") else {
				throw CocoaError(.fileReadInvalidFileName)
			}

			print("Loading bestiary data.")
			// TODO: load bestiary data
		 } catch {
			// TODO: cover more cases
			throw CocoaError(.fileReadCorruptFile)
		}
	}

	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		throw JSONFileError.notImplemented
	}

	public func testingDocConfig() -> FileDocumentReadConfiguration {

		let f = FileDocumentReadConfiguration()

		return f

	}
}
