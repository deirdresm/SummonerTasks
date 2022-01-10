//
//  BestiaryView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import SwiftUI
import CoreData

struct BestiaryView: View {
	public enum ViewMode: String, CaseIterable, Identifiable {
		 var id: Self { self }
		 case bestiary
		 case dungeon
	 }

	@Binding var monster: Monster
	@State var searchText: String = ""
	@SceneStorage("viewMode") private var mode: ViewMode = .bestiary
	@State private var selection = Set<Monster>()

	@State var sortOrder: [KeyPathComparator<Monster>] = [
	 .init(\.familyId, order: SortOrder.forward)
	]

//	let monsters: [Monster]

	// TODO: write this function
	var table: some View {
		Text("yo")
	}

    var body: some View {
		Group {
			switch mode {
			case .bestiary:
				table
			case .dungeon:
				table	// TODO: fix
			}
		}
//		.focusedSceneValue(\.monster, monster)
//		.focusedSceneValue(\.selection, $selection)
		.searchable(text: $searchText)
//		.toolbar {
//			BestiaryToolbar(mode: $mode)
//		}

//        let baleygr = Monster.baleygr
//        let ancientSword = Building.ancientSword
        VStack {
            // summary of towers up top
            HStack {
                BuildingIconView(building: Building.ancientSword, level: 0)
                BuildingIconView(building: Building.darkSanctuary, level: 0)
            }
        }
    }
}


struct BestiaryView_Previews: PreviewProvider {

    static var previews: some View {
		BestiaryView(monster: .constant(Monster.lightSlayer))
        .previewLayout(.fixed(width: 600, height: 800))
    }
}
