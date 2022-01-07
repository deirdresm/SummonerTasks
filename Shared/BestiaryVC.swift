//
//  BestiaryVC.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/21.
//

import Foundation
import SwiftUI

class BestiaryVC {

	// for tab at the top of the screen showing what section we're looking at
	// e.g., like the
	public enum ViewMode: String, CaseIterable, Identifiable {
	 var id: Self { self }
	 case bestiary
	 case dungeon
 }

}

extension BestiaryVC.ViewMode {

	var labelContent: (name: String, systemImage: String) {
		switch self {
		case .bestiary:
			return ("Bestiary", "hare.fill")
		case .dungeon:
			return ("Dungeon", "shield.righthalf.fill")
		}
	}

	var label: some View {
		let content = labelContent
		return Label(content.name, systemImage: content.systemImage)
	}
}
