//
//  ContentView.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import CoreData

struct BuildingList: View {
    var type: BuildingFilter
    var gridItems: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 150))]
    
    @Binding var document: SummonerJsonDocument
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
        LazyHGrid(rows: gridItems, alignment: .center, spacing: 10) {
            let buildings = Building.filteredBuildings(type)
            ForEach(buildings.indices) { i in
                let building = buildings[i]
                let level = BuildingInstance.getBuildingLevel(document.docInfo.summonerId, building.id, context: moc)
                BuildingIconView(building: building, level: level)
                    .frame(width: 120, height: 120, alignment: .top)
            }
        }
        .frame(width: .infinity, height: 100, alignment: .top)

    }
}

struct ContentView: View {
    @Binding var document: SummonerJsonDocument
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
            VStack {
                HStack {
                    Text((document.docInfo.summoner != nil) ? "Hello \((document.docInfo.summoner?.name)!)." : "Hello.")
                        .font(.headline)
                    Spacer()
                    BuildingList(type: .battle, document: $document)
                }
                .frame(width: .infinity)
                
                RuneList(docInfo: document.docInfo)
            }
            .padding()
            .frame(width: .infinity, height: 150, alignment: .top)
    }

    private func addMonster() {
        withAnimation {
            let newBuilding = Building(context: moc)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteMonsters(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { battleBuildings[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static let text = Bundle.main.openBundleFile(from: "building-mini.json")
    static var document: SummonerJsonDocument = {
        return try! SummonerJsonDocument(text: text, summoner: Summoner.tisHerself)
    }()
    
    static var previews: some View {
        ContentView(document: .constant(document))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
