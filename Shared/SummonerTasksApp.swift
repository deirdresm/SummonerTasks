//
//  SummonerTasksApp.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI

@main
struct SummonerTasksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        DocumentGroup(newDocument: SummonerTasksDocument()) { file in
            ContentView(document: file.$document)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
