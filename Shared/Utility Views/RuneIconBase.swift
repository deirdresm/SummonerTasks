//
//  RuneIconBase.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/20/20.
//

import Foundation
import SwiftUI

public struct RuneIconBase: View {
    
    let rune: RuneInstance
        
//    let runeType: RuneType
//    let numStars: Int
//    let level: Int // TODO - also need original quality
//    let slot: Int
        
    public var body: some View {
        let runeName = rune.runeTypeName
        let runeQuality = RuneQuality.runeLevel(level: rune.level)
        let rotation = (60 * (rune.slot - 1))
        let x_offset = 2.0 * cos(Double((rotation) % 360))
        let y_offset = 2.0 * sin(Double((rotation) % 360))

        // needs to be converted into a LazyZStack except there is none
        
        ZStack{
            Image(
                ImageStore.loadImage(type: .runes, name: "bg_\(runeQuality)"),
                scale: 1,
                label: Text("")
            )
            Image(
                ImageStore.loadImage(type: .runes, name: "rune\(rune.slot)"),
                scale: 1,
                label: Text("")
            )
//            .rotationEffect(.degrees(Double(rotation)))
           Image(
                ImageStore.loadImage(type: .runes, name: runeName),
                scale: 2,
                label: Text("")
            )
           .offset(CGSize(width: x_offset, height: y_offset))
        }
    }
}

struct RuneIconBase_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            RuneIconBase(rune: RuneInstance.swiftSpeed)
            RuneIconBase(rune: RuneInstance.focusSlot6)
        }
        .previewLayout(.fixed(width: 77, height: 77))
    }
}
