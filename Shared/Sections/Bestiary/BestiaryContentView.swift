//
//  BestiaryContentView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/21.
//

import SwiftUI

struct BestiaryContentView: View {
//	@EnvironmentObject var persistence: Persistence
	@StateObject var viewModel: ViewModel

	var body: some View {
		NavigationView {
			BestiarySidebar(viewModel: viewModel)

			if let monster = viewModel.selectedMonster {
				MonsterDetail(monster: monster)
			}
		}
	}

	/// init for previews
	init(persistence: Persistence) {
		let viewModel = ViewModel(persistence: persistence)
		_viewModel = StateObject(wrappedValue: viewModel)
	}

	/// Init for 
}

struct BestiaryContentView_Previews: PreviewProvider {
	static var persistence = Persistence.preview

    static var previews: some View {
		BestiaryContentView(persistence: persistence)
			.environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
