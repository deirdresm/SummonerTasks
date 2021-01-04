//
//  Source+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/29/20.
//

import Foundation
import CoreData

extension Source {
    
    public static var fusion: Source {
        let source = Source(context: PersistenceController.shared.container.viewContext)
        source.id = 35
        source.name = "Fusion"
        source.imageFilename = "fusion.png"
        source.c2uDescription = ""
        source.isFarmable = true
        source.metaOrder = 0
        source.id = 35
        
        return source
    }
}

/*
 {
   "model": "bestiary.source",
   "pk": 35,
   "fields": {
     "name": "Fusion",
     "description": "",
     "icon_filename": "fusion.png",
     "farmable_source": true,
     "meta_order": 0
   }
 },
*/
