//
//  BestiaryDocument.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/21.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine

class BestiaryDocument: FileDocument {
	static var readableContentTypes: [UTType] { [.json] }

	required init(configuration: ReadConfiguration) throws {
		<#code#>
	}

	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		<#code#>
	}


}

