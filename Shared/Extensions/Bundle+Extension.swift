//
//  Bundle+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/6/20.
//

import Foundation

extension Bundle {
    
    /// Convenience method to get a bundle image file path.
    static func imageFilePath(type: ImageType, name: String) -> String {
        let partialPath = type.rawValue
        let path = partialPath.appending("/\(name)")
        return(path)
    }

	/// Open a file from within our bundle.
    func openBundleFile(from file: String) -> String {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return String(decoding: data, as: UTF8.self)
    }

	/// Decode JSON from our bundle.
	func decode<T: Decodable>(
		_ type: T.Type,
		from file: String,
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
		keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {

		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load contents of \(file) from bundle.")
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy
		decoder.keyDecodingStrategy = keyDecodingStrategy

		do {
			return try decoder.decode(T.self, from: data)
		} catch DecodingError.keyNotFound(let key, let context) {
			// swiftlint:disable:next line_length
			fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
		} catch DecodingError.typeMismatch(_, let context) {
			fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
		} catch DecodingError.valueNotFound(let type, let context) {
			fatalError("Failed to decode \(file) from bundle due to missing \(type) value  - \(context.debugDescription)")
		} catch DecodingError.dataCorrupted(_) {
			fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
		} catch {
			fatalError("Failed to decode \(file) from bundle because reasons - \(error.localizedDescription)")
		}
	}
}
