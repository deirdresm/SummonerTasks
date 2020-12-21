//
//  BestiaryMonsterIconView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/14/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import SwiftUI

struct MonsterIconView: View {
    var monster: Monster
    
    var body: some View {
        VStack {
            Monster.portrait(monster: monster)
                .centerCropped()
                .frame(width: 100, height: 97)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.black, lineWidth: 2.5) // TODO: color based on element
                )
            Text("\(monster.name!)")
                .font(.subheadline)
                .lineLimit(10)
                .offset(x: 0, y: -2)
                .padding(.horizontal)
            StarsView(numStars: 5, awakening: .awakened)
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
                .offset(x: 0, y: -10)
            Spacer()
        }
        .frame(width:110, height:138)
        .padding(.vertical)
    }
}

struct MonsterIconView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MonsterIconView(monster: Monster.lightSlayer)
            MonsterIconView(monster: Monster.darkSlayer)
        }
        .previewLayout(.fixed(width: 110, height: 182))
    }
}
