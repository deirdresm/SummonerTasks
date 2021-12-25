//
//  BuildingListView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/4/21.
//

import SwiftUI
import CoreData

struct BuildingList: View {
    var type: BuildingFilter
    var gridItems: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 150))]
    
    @Binding var document: SWDocument
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
        LazyHGrid(rows: gridItems, alignment: .center, spacing: 10) {
            let buildings = Building.filteredBuildings(type)
            ForEach(buildings) { building in
                let level = BuildingInstance.getBuildingLevel(document.docInfo.summonerId, building.id, context: moc)
                BuildingIconView(building: building, level: level)
                    .frame(width: 120, height: 120, alignment: .top)
            }
        }
    }
}

