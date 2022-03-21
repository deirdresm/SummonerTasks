//
//  BestiaryToolbar.swift
//  SummonerTasks (macOS)
//
//  Created by Deirdre Saoirse Moen on 12/25/21.
//

import SwiftUI

struct BestiaryToolbar: View {
	@Binding var mode: BestiaryContentView.ViewModel.ViewMode
    var body: some View {
		Picker("Display Mode", selection: $mode) {
			ForEach(BestiaryContentView.ViewModel.ViewMode.allCases) { viewMode in
				viewMode.label
			}
		}
		.pickerStyle(SegmentedPickerStyle())
    }
}

struct BestiaryToolbar_Previews: PreviewProvider {



    static var previews: some View {
		let mode: BestiaryContentView.ViewModel.ViewMode = .bestiary
		BestiaryToolbar(mode: .constant(mode))
    }
}
