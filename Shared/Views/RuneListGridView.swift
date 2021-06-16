//
//  RuneListOne.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/22/21.
//

import Foundation
import SwiftUI

extension VerticalAlignment {
    struct SlotAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    struct StarAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    struct CurrEffAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.trailing]
        }
    }

    struct MaxEffAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.trailing]
        }
    }

    static let slotAlign = VerticalAlignment(SlotAlign.self)

    static let starAlign = VerticalAlignment(StarAlign.self)

    static let currEffAlign = VerticalAlignment(CurrEffAlign.self)

    static let maxEffAlign = VerticalAlignment(MaxEffAlign.self)
}

public struct PercentText: View {
    var pct: Float
    var digits: Int
    var trailing: Int
    
    public var body: some View {
        let str = String(format: "%\(digits).\(trailing)f", pct * 100.0)
        return Text("\(str)%")
    }

}

public struct RuneList: View {
    var docInfo: SummonerDocumentInfo
    
    public var body: some View {
        if let summoner = docInfo.summoner {
            VStack {
                Text("Rune List")
                    .font(.headline)
                RuneListGridView(runes: summoner.runesSorted())
            }
        } else {
            EmptyView()
        }
    }
}

// list one rune
public struct RuneListGridView: View {
    var viewContext = PersistenceController.shared.container.viewContext

    var runes: [RuneInstance]
    
    let columns: [GridItem] = [
        GridItem(.fixed(48)), // icon
        GridItem(.fixed(30), spacing: 1, alignment: .trailing), // slot
        GridItem(.fixed(30), spacing: 1, alignment: .trailing), // stars
        GridItem(.fixed(50), spacing: 1, alignment: .trailing), // efficiency
        GridItem(.fixed(50), spacing: 1, alignment: .trailing), // max efficiency
        GridItem(.fixed(40), spacing: 1, alignment: .trailing), // hpPct
        GridItem(.fixed(50), spacing: 1, alignment: .trailing), // hpFlat
        GridItem(.fixed(40), spacing: 1, alignment: .trailing), // atkPct
        GridItem(.fixed(30), spacing: 1, alignment: .trailing), // atkFlat
        GridItem(.fixed(40), spacing: 1, alignment: .trailing), // defPct
        GridItem(.fixed(30), spacing: 1, alignment: .trailing), // defFlat
        GridItem(.fixed(30), spacing: 1, alignment: .trailing), // speed
        GridItem(.fixed(45), spacing: 1, alignment: .trailing), // crit rate
        GridItem(.fixed(45), spacing: 1, alignment: .trailing), // crit dmg
        GridItem(.fixed(45), spacing: 1, alignment: .trailing), // resistance
        GridItem(.fixed(45), spacing: 1, alignment: .trailing), // accuracy
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
                        .alignmentGuide(.slotAlign) { d in d[HorizontalAlignment.center] }
                    Text("\(rune.stars)*")
                        .alignmentGuide(.starAlign) { d in d[HorizontalAlignment.center] }
                    PercentText(pct: rune.efficiency, digits: 5, trailing: 1)
                        .alignmentGuide(.currEffAlign) { d in d[HorizontalAlignment.trailing] }
               }
                Group {
                    PercentText(pct: rune.maxEfficiency, digits: 5, trailing: 1)
                        .alignmentGuide(.maxEffAlign) { d in d[HorizontalAlignment.trailing] }
                    Text("\(rune.hpPct)%")
                    Text("\(rune.hpFlat)")
                    Text("\(rune.atkPct)%")
                }
                Group {
                    Text("\(rune.atkFlat)")
                    Text("\(rune.defPct)%")
                    Text("\(rune.defFlat)")
                    Text("\(rune.speed)")
                }
                Group {
                    Text("\(rune.critRate)%")
                    Text("\(rune.critDmg)%")
                    Text("\(rune.resistance)%")
                    Text("\(rune.accuracy)%")
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
