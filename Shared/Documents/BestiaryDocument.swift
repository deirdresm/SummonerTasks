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

	required init(configuration: ReadConfiguration) throws {
		do {
			// what we do depends on the filename

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

		text = ""
	}

	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		throw JSONFileError.notImplemented
	}

}
