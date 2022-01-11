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
	@SceneStorage("viewMode") private var mode: BestiaryVC.ViewMode = .bestiary

    let persistence = Persistence.shared

    var body: some Scene {
        DocumentGroup(viewing: SWDocument.self) { file in
            ContentView(document: file.$document)
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
		DocumentGroup(viewing: BestiaryDocument.self) { file in
			BestiaryContentView(document: file.$document)
				.environment(\.managedObjectContext, persistence.container.viewContext)
				.toolbar {
					BestiaryToolbar(mode: $mode)
				}
		}
        .onChange(of: scenePhase) { _ in
            do {
                try persistence.container.viewContext.save()
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
