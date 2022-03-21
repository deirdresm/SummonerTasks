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
	var checksum: Int = 0

	/// Currently only used by testing and previews.
	init(text: String) {
		self.text = text
	}

	// TODO: calc checksum and see if it matches UserDefaults for saved checksum after successful import.

	func updateChecksum() {

	}

	func calcChecksum() -> String {
		return ""
	}

	func isFileUpdated() -> Bool {
		return true // TODO: we're forcing true during development, but need to fix this for production
	}


	required init(configuration: ReadConfiguration) throws {
		let checksum: String

		do {
			guard let data = configuration.file.regularFileContents else {
				// TODO: cover more cases
				throw CocoaError(.fileReadCorruptFile)
			}

			checksum = data.md5 ?? ""

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
}
