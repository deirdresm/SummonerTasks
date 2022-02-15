//
//  BestiarySidebar.swift
//  SummonerTasks (macOS)
//
//  Created by Deirdre Saoirse Moen on 12/25/21.
//

import SwiftUI

// TODO: make this bestiary-ish
struct BestiarySidebar: View {
	var document: BestiaryDocument = BestiaryDocument(text: "")
	@Environment(\.managedObjectContext) private var moc

	@Binding var selection: RuneType?

	@FetchRequest(entity: RuneInstance.entity(), sortDescriptors: [])

	private var runes: FetchedResults<RuneInstance>

	var body: some View {
		List(selection: $selection) {
			ForEach(RuneInstance.displayRuneTypes) { runeType in
				RuneSidebarLabel(runeType: runeType)
//                    .badge(garden.numberOfPlantsNeedingWater)
			}
		}
		.frame(minWidth: 250)
}

	struct RuneSidebarLabel: View {
		@State var runeType: RuneType
		@State var imageType = ImageType.runes

		var body: some View {
			Label {
				Text(runeType.description.firstCapitalized)
			} icon: {
				LoadedImage(imageType: $imageType, imageName: "\(runeType.description)")
					.scaleEffect(0.5, anchor: .center)
					.frame(height: 24)
			}
			.labelStyle(.titleAndIcon)
		}
    }
}

struct BestiarySidebar_Previews: PreviewProvider {
	static let text = Bundle.main.openBundleFile(from: "runes-mini.json")
	@State static var selection: RuneType? = .violent

	static var previews: some View {
		BestiarySidebar(selection: $selection)
	}
}
