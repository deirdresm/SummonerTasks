//
//  BestiaryVC.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/21.
//

import Foundation
import SwiftUI

extension BestiaryContentView {
	class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {

		var bestiaryProvider: BestiaryProvider = .shared

		@Published var selectedMonster: Monster?

		@Published var monsters = [Monster]()
		@Published var filteredMonsters = ArraySlice<Monster>()
		private let monstersController: NSFetchedResultsController<Monster>

		@Published var dungeons = [Dungeon]()
		@Published var selectedDungeon: Dungeon?
		@Published var filteredDungeons = ArraySlice<Dungeon>()
		private let dungeonsController: NSFetchedResultsController<Dungeon>

		var persistence: Persistence

		init(persistence: Persistence) {
			self.persistence = persistence
			// Construct a fetch request to show all open projects.
			let monsterRequest: NSFetchRequest<Monster> = Monster.fetchRequest()
			monsterRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Monster.familyId, ascending: false)]

			monstersController = NSFetchedResultsController(
				fetchRequest: monsterRequest,
				managedObjectContext: persistence.container.viewContext,
				sectionNameKeyPath: nil,
				cacheName: nil
			)

			let dungeonRequest: NSFetchRequest<Dungeon> = Dungeon.fetchRequest()
			dungeonRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Dungeon.id, ascending: true)]

			dungeonsController = NSFetchedResultsController(
				fetchRequest: dungeonRequest,
				managedObjectContext: persistence.container.viewContext,
				sectionNameKeyPath: nil,
				cacheName: nil
			)

			super.init()

			monstersController.delegate = self
			dungeonsController.delegate = self

			do {
				try monstersController.performFetch()
				try dungeonsController.performFetch()
				monsters = monstersController.fetchedObjects ?? []
				dungeons = dungeonsController.fetchedObjects ?? []
			} catch {
				print("Failed to fetch initial data.")
			}
		}

		// MARK: Convenience methods

		func setSelectedMonster(id: Int) {
			selectedMonster = Monster.findById(Int64(id), context: persistence.container.viewContext)
		}

		func findMonsterById(id: Int) -> Monster? {
			return Monster.findById(Int64(id), context: persistence.container.viewContext)
		}

		// MARK: View Mode toggle support
		@Published var bestiaryMode: ViewModel.ViewMode = .bestiary

		// for tab at the top of the screen showing what section we're looking at
		// e.g., like the
		public enum ViewMode: String, CaseIterable, Identifiable {
			var id: Self { self }
			case bestiary
			case dungeon
		}

		static var bestiary: ViewModel.ViewMode = .bestiary
		static var dungeon: ViewModel.ViewMode = .dungeon

	} // ViewModel
}

extension BestiaryContentView.ViewModel.ViewMode {

	var labelContent: (name: String, systemImage: String) {
		switch self {
		case .bestiary:
			return ("Bestiary", "hare.fill")
		case .dungeon:
			return ("Dungeon", "shield.righthalf.fill")
		}
	}

	var label: some View {
		let content = labelContent
		return Label(content.name, systemImage: content.systemImage)
	}
}
