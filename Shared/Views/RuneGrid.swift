//
//  RuneGrid.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/20.
//

import Foundation
import SwiftUI
import CoreData

//struct RuneGridView: View {
//    var viewContext = PersistenceController.shared.container.viewContext
//
//    var runes: [RuneInstance]
//    
//    let columns: [GridItem] = [
//        GridItem(.fixed(116)),
//        GridItem(.fixed(116)),
//        GridItem(.fixed(116)),
//        GridItem(.fixed(116)),
//        GridItem(.fixed(116))
//    ]
//    
//    init(runes: [RuneInstance]) {
//        self.runes = runes
//    }
//
//    var body: some View {
//        LazyVGrid(columns: columns) {
//            
//            ForEach(runes, id:\.id) { rune in
//                RuneIconView(rune: rune.type.rawValue, numStars: rune.numStars, level: rune.level, slot: rune.slot)
//            }
//            
//        }
//    }
//}
//
//struct RuneGrid_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RuneGridView(runes: RuneInstance.sampleRunes)
//        .previewLayout(.fixed(width: 696, height: 812))
//    }
//}
