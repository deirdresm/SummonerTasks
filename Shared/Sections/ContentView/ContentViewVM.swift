//
//  HomeVM.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/15/22.
//

import CoreData
import SwiftUI

/// Keeps track of the DB and SummonerTasksDocument for ContentView and related.
extension ContentView {
	class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
		let persistence: Persistence
		let document: SWDocument

		var showingSortOrder = false

		private let monstersController: NSFetchedResultsController<Monster>
		@Published var monsters = [Monster]()

		lazy var summonerName: String = {
			document.docInfo.summoner?.name ?? ""
		}()

		init(persistence: Persistence, document: SWDocument) {
			self.persistence = persistence
			self.document = document

			let request: NSFetchRequest<Monster> = Monster.fetchRequest()
			request.sortDescriptors = [NSSortDescriptor(keyPath: \Monster.com2usId, ascending: false)]

			monstersController = NSFetchedResultsController(
				fetchRequest: request,
				managedObjectContext: persistence.container.viewContext,
				sectionNameKeyPath: nil,
				cacheName: nil
			)
			super.init()
			monstersController.delegate = self

			do {
				try monstersController.performFetch()
				monsters = monstersController.fetchedObjects ?? []
			} catch {
				print("Failed to fetch projects")
			}
		}
	}
}
