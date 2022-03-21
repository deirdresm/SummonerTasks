//
//  Optional+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 3/19/22.
//

import Foundation

// Shamelessly lifted from: https://github.com/Ckitakishi/PaletteTheme/blob/main/Sources/Utils/Optional%2BExtensions.swift

extension Optional where Wrapped == String {
	var orEmpty: String {
		self ?? ""
	}
}


extension Optional where Wrapped == Date {
	var orNow: Date {
		self ?? Date()
	}
}
