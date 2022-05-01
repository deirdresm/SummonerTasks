//
//  BestiarySidebar.swift
//  SummonerTasks (macOS)
//
//  Created by Deirdre Saoirse Moen on 12/25/21.
//

import SwiftUI

// TODO: make this bestiary-ish
struct BestiarySidebar: View {
//	var document: BestiaryDocument = BestiaryDocument(text: "")
	@StateObject var viewModel: BestiaryContentView.ViewModel

	@Environment(\.managedObjectContext) private var moc

	@AppStorage("monsterFamily") private var defaultMonsterId = 19801
	@SceneStorage("selectedMonsterId") private var selectedMonsterId: Int = 19811 // Lapis

	@State private var monsterId: Monster?

	let monsterRequest: NSFetchRequest<Monster> = Monster.fetchRequest()

//	private var runes: FetchedResults<RuneInstance>

	var body: some View {
		List {
			ForEach(RuneInstance.displayRuneTypes) { runeType in
				RuneSidebarLabel(runeType: runeType)
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

	private var selectedMonster: Binding<Int> {
		Binding(
			get: {
				selectedMonsterId
			}, // get

			set: {
				selectedMonsterId = $0
			} // set
		) // Binding
	}
}

struct BestiarySidebar_Previews: PreviewProvider {
	static var persistence = Persistence.preview

	static let text = Bundle.main.openBundleFile(from: "runes-mini.json")
//	static var document: BestiaryDocument = {
//		return try! BestiaryDocument(text: text)
//	}()

	static let viewModel = BestiaryContentView.ViewModel(persistence: persistence)
	@State static var selection: RuneType? = .violent

	static var previews: some View {
		BestiarySidebar(viewModel: viewModel)
			.environment(\.managedObjectContext, persistence.container.viewContext)
	}
}
