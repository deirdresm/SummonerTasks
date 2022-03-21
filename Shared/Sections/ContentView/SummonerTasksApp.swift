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
	@SceneStorage("viewMode") private var mode: BestiaryContentView.ViewModel.ViewMode = .bestiary

    let persistence = Persistence.shared

    var body: some Scene {
        DocumentGroup(viewing: SWDocument.self) { file in
			ContentView(persistence: persistence, document: file.document)
				.environmentObject(persistence)
        }
		.onChange(of: scenePhase) { phase in
			do {
				try persistence.container.viewContext.save()
			} catch {
				print("error saving")
			}
			switch scenePhase {
			case .active:
				print("active phase")
			case .inactive:
				print("inactive phase")
			case .background:
				print("background phase")
			@unknown default:
				print("Some other phase goes here")
			}
		}
		WindowGroup {
			BestiaryContentView(persistence: persistence)
		}
    }
}
