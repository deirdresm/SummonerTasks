//
//  Summoner+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/20.
//

import Foundation

extension Summoner {
    
    public static var tisHerself: Summoner {
        let summoner = Summoner(context: PersistenceController.shared.container.viewContext)
        summoner.id = 14
        summoner.name = "TisHerself"

        return summoner
    }
}
