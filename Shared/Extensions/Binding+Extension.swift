//
//  Binding+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/14/22.
//

import Foundation
import SwiftUI

extension Binding {
	func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
		Binding(
			get: { self.wrappedValue },
			set: { newValue in
				self.wrappedValue = newValue
				handler()
			}
		)
	}
}
