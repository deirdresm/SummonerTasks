//
//  RuneListOne.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/22/21.
//

import Foundation
import SwiftUI

// list one rune
public struct RuneListGridView: View {
    var viewContext = PersistenceController.shared.container.viewContext

    var runes: [RuneInstance]
    
    let columns: [GridItem] = [
        GridItem(.fixed(48)), // icon
        GridItem(.fixed(30)), // slot
        GridItem(.fixed(30)), // stars
        GridItem(.fixed(30)), // efficiency
        GridItem(.fixed(30)), // max efficiency
        GridItem(.fixed(40)), // hpPct
        GridItem(.fixed(30)), // hpFlat
        GridItem(.fixed(40)), // atkPct
        GridItem(.fixed(30)), // atkFlat
        GridItem(.fixed(40)), // defPct
        GridItem(.fixed(30)), // defFlat
        GridItem(.fixed(30)), // speed
        GridItem(.fixed(30)), // crit rate
        GridItem(.fixed(30)), // crit dmg
        GridItem(.fixed(30)), // resistance
        GridItem(.fixed(30)), // accuracy
    ]
    
    init(runes: [RuneInstance]) {
        self.runes = runes
    }

    public var body: some View {
        LazyVGrid(columns: columns) {
            
            ForEach(runes, id:\.id) { rune in
                Group {
                    RuneIconView(rune: rune)
                        .frame(minWidth: 36, idealWidth: 48, maxWidth: 48, minHeight: 36, idealHeight: 48, maxHeight: 48, alignment: .leading)
                    Text("\(rune.slot)")
                    Text("\(rune.stars)")
                    Text("\(rune.efficiency)")
                    Text("\(rune.maxEfficiency)")
                    Text("\(rune.hpPct)%")
                    Text("\(rune.hpFlat)")
                    Text("\(rune.atkPct)%")
                    Text("\(rune.atkFlat)")
                    Text("\(rune.defPct)%")
                }
                Group {
                    Text("\(rune.defFlat)")
                    Text("\(rune.speed)")
                    Text("\(rune.critRate)")
                    Text("\(rune.critDmg)")
                    Text("\(rune.resistance)")
                    Text("\(rune.accuracy)")
                }
            }
            
        }
    }
}

struct RuneListGrid_Previews: PreviewProvider {

    static var previews: some View {
        RuneListGridView(runes: RuneInstance.sampleRunes)
        .previewLayout(.fixed(width: 696, height: 812))
    }
}
