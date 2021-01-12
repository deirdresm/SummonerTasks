//
//  BJr5.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/10/20.
//

import Foundation
import SwiftUI


struct BJr5: View {
    let monsters: [Monster]

    var body: some View {
        
        let summoner = Summoner.tisHerself
        let baleygr = Monster.baleygr
        let ancientSword = Building.ancientSword
        
        VStack {
            
            // summary of towers up top
            HStack {
                BuildingIconView(building: Building.ancientSword, buildingInstance: nil)
                BuildingIconView(building: Building.darkSanctuary, buildingInstance: nil)
            }
        }
    }
}


struct BJr5_Previews: PreviewProvider {

    static var previews: some View {
        BJr5(monsters: [Monster.lightSlayer, Monster.darkSlayer])
        .previewLayout(.fixed(width: 600, height: 800))
    }
}
