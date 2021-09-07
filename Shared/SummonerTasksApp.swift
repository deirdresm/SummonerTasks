//
//  SummonerTasksApp.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI

@main
struct SummonerTasksApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        DocumentGroup(viewing: SummonerJsonDocument.self) { file in
            ContentView(document: file.$document)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            do {
                try persistenceController.container.viewContext.save()
            } catch {
                print("error saving")
            }
//            switch phase {
//            case .active:
//                print("active phase")
//            case .inactive:
//                print("inactive phase")
//            case .background:
//                print("background phase")
//            @unknown default:
//                print("Some other phase goes here")
//            }
        }
    }
}
