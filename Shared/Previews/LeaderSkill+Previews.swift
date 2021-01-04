//
//  LeaderSkill+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/27/20.
//

import Foundation

/*
 {
   "model": "bestiary.leaderskill",
   "pk": 183,
   "fields": {
     "attribute": 2,
     "amount": 44,
     "area": 5,
     "element": null
   }
 },
*/

extension LeaderSkill {
    
    public static var baleygrLeader: LeaderSkill {
        let baleygr = LeaderSkill(context: PersistenceController.shared.container.viewContext)
        baleygr.id = 183
        baleygr.attribute = 2
        baleygr.amount = 44
        baleygr.area = 5
        baleygr.element = nil

        return baleygr
    }
}
