//
//  BestiaryToolbar.swift
//  SummonerTasks (macOS)
//
//  Created by Deirdre Saoirse Moen on 12/25/21.
//

import SwiftUI

struct BestiaryToolbar: View {
	@Binding var mode: BestiaryVC.ViewMode
    var body: some View {
		Picker("Display Mode", selection: $mode) {
			ForEach(BestiaryVC.ViewMode.allCases) { viewMode in
				viewMode.label
			}
		}
		.pickerStyle(SegmentedPickerStyle())
    }
}

struct BestiaryToolbar_Previews: PreviewProvider {
    static var previews: some View {
		BestiaryToolbar(mode: BestiaryVC.ViewMode.bestiary)
    }
}
