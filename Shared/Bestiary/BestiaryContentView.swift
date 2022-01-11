//
//  BestiaryContentView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/21.
//

import SwiftUI

struct BestiaryContentView: View {
	@EnvironmentObject var persistence: Persistence
	@Binding var document: BestiaryDocument = BestiaryDocument(text: "")

	@SceneStorage("selectedMonster") private var selectedMonsterId: (Monster.com2usId)?
	@AppStorage("monsterFamily") private var defaultMonsterId: Monster.com2usId?
	@SceneStorage("selectedDungeon") private var selectedDungeonId: (Dungeon.com2usId)?
	@AppStorage("defaultDungeon") private var defaultDungeonId: Dungeon.com2usId?


	var body: some View {
		NavigationView {
			BestiarySidebar(document: document, selection: selection)
			MonsterDetail(monster: selectedMonsterId)
		}
	}

	private var selection: Binding<Monster?> {
		Binding(get: { selectedMonsterId ?? defaultMonsterId },
				set: { selectedMonsterId = $0 })
	}

	private var selectedDungeon: Binding<Dungeon> {
		Binding(get: { selectedDungeonId ?? defaultDungeonId },
				set: { selectedDungeonId = $0 })
	}
}

struct BestiaryContentView_Previews: PreviewProvider {
	static var persistence = Persistence.preview
    static var previews: some View {
		BestiaryContentView()
    }
}
