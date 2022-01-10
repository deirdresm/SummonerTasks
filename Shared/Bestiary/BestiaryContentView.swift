//
//  BestiaryContentView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/21.
//

import SwiftUI

struct BestiaryContentView: View {
	@EnvironmentObject var persistence: Persistence

	@SceneStorage("selection") private var selectedMonsterId: (Monster.com2usId)?
	@AppStorage("monsterFamily") private var defaultMonsterId: Monster.com2usId?

	var body: some View {
		NavigationView {
			BestiarySidebar(document: <#BestiaryDocument#>, selection: selection)
			MonsterDetail(monster: selectedMonsterId)
		}
	}

	private var selection: Binding<Monster?> {
		Binding(get: { selectedMonsterId ?? defaultMonsterId }, set: { selectedMonsterId = $0 })
	}

	private var selectedGarden: Binding<Monster> {
		$store[selection.wrappedValue]
	}
}

struct BestiaryContentView_Previews: PreviewProvider {
	static var persistence = PersistenceController.preview

    static var previews: some View {
        BestiaryContentView()
    }
}
