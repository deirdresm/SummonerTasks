//
//  MonsterDetail.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/28/21.
//

import Foundation
import SwiftUI

struct MonsterDetail: View {
	var monster: Monster
	
	var body: some View {
		Section(header: Text("Basic Info")) {
			Text(monster.nameWrapped)
				.font(.title).bold()
		}
	}
}
