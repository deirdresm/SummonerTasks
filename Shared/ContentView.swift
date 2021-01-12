//
//  ContentView.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Binding var document: SummonerJsonDocument
    @Environment(\.managedObjectContext) private var viewContext


    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Building.com2usId, ascending: true)],
        animation: .default)
    
    private var buildings: FetchedResults<Building>
    
    var gridItems: [GridItem] = [GridItem(.fixed(150)), GridItem(.fixed(150)), GridItem(.fixed(150)), GridItem(.fixed(150)), GridItem(.fixed(150))]

    var body: some View {
        VStack {
            HStack {
                Text("Hello.")
                    .font(.headline)
                Spacer()
            }
            
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 20) {
                
                ForEach(buildings) { building in
                    BuildingIconView(building: building, buildingInstance: nil)
                }
            }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addMonster) {
//                Label("Add Monster", systemImage: "plus")
//            }
//        }
        }
    }

    private func addMonster() {
        withAnimation {
            let newBuilding = Building(context: viewContext)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteMonsters(offsets: IndexSet) {
        withAnimation {
            offsets.map { buildings[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
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
        return try! SummonerJsonDocument(text: text)
    }()
    
    static var previews: some View {
        ContentView(document: .constant(document))
    }
}
