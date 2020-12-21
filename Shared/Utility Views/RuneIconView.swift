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
                Text(rune.runeTypeName.firstCapitalized)
                    .font(.headline)
                    .lineLimit(10)
                    .offset(x: 0, y: -5)
                    .padding(.horizontal)
            }
            StarsView(numStars: rune.stars, awakening: .unawakened)
            .frame(width: 57)
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 10))
            Spacer()
            HStack {
                ZStack{
                    Text("+\(rune.level)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .blur(radius: 2)
                        .padding(EdgeInsets(top: 33, leading: 5, bottom: 0, trailing: 0))
                    Text("+\(rune.level)")
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 33, leading: 5, bottom: 0, trailing: 0))
                        }
                Spacer()
            }
            Spacer()
                .padding(.bottom)
        }
        .frame(width:77, height:107)
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
