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

extension Optional where Wrapped == [Int64] {
	var orIntArray: [Int64] {
		self ?? []
	}
}

extension Optional where Wrapped == Bool {
	var orFalse: Bool {
		self ?? false
	}
}


extension Optional where Wrapped == Date {
	var orNow: Date {
		self ?? Date()
	}
}

extension Optional where Wrapped == Any {
	var orEmpty: String {
		(self as? String) ?? ""
	}

	var orInt: Int64 {
		(self as? Int64) ?? Int64(0)
	}

	var orInt16: Int16 {
		(self as? Int16) ?? Int16(0)
	}

	var orIntArray: [Int64] {
		(self as? [Int64]) ?? []
	}

	var orFalse: Bool {
		(self as? Bool) ?? false
	}

	var orOptionalInt: NSNumber? {
		if (self != nil) {
			return self as? NSNumber
		} else {
			return nil
		}
	}

//	var orOptionalInt: Int64? {
//		if (self != nil) {
//			return self as? Int64
//		} else {
//			return nil
//		}
//	}
}
