//
//  RuneIconView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/14/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import SwiftUI

struct RuneIconView: View {

    var rune: RuneInstance
    
    var body: some View {
        ZStack {
            VStack {
                RuneIconBase(rune: rune)
                    .frame(width: 77, height: 77)
                    .padding(EdgeInsets(top: 7, leading: 2, bottom: 0, trailing: 2))
//                Text(rune.runeTypeName.firstCapitalized)
//                    .font(.subheadline)
//                    .lineLimit(10)
//                    .offset(x: 0, y: -5)
//                    .padding(.horizontal)
                Spacer()
            }
            
            // middle layer: rune stars
            StarsView(numStars: rune.stars, awakening: rune.awakening)
            .frame(width: 57)
            .padding(EdgeInsets(top: 12, leading: 10, bottom: 0, trailing: 10))
            Spacer()
            
            // top layer: rune + value
            VStack {
                Spacer()
            HStack {
                ZStack{
                    // blur same text behind (but in black) to make white text stand out more
                    Text("+\(rune.level)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .blur(radius: 2)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 12, trailing: 0))
                    Text("+\(rune.level)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 12, trailing: 0))
                }
                Spacer()
            }
            }
        }
        .frame(width:81, height:81)
    }
}

struct RuneIconView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RuneIconView(rune: RuneInstance.swiftSpeed)
            RuneIconView(rune: RuneInstance.focusSlot6)
        }
        .previewLayout(.fixed(width: 77, height: 107))
    }
}
