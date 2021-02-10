//
//  BestiaryView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/18/20.
//

import Foundation
import SwiftUI
import CoreData

struct BestiaryView: View {
    let monsters: [Monster]

    var body: some View {

        let baleygr = Monster.baleygr
        
        let ancientSword = Building.ancientSword
        VStack {
            
            // summary of towers up top
            HStack {
                BuildingIconView(building: Building.ancientSword, level: 0)
                BuildingIconView(building: Building.darkSanctuary, level: 0)
            }
        }
    }
}


struct BestiaryView_Previews: PreviewProvider {

    static var previews: some View {
        BestiaryView(monsters: [Monster.lightSlayer, Monster.darkSlayer])
        .previewLayout(.fixed(width: 600, height: 800))
    }
}
