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
        sortDescriptors: [NSSortDescriptor(keyPath: \Monster.com2usID, ascending: true)],
        animation: .default)
    
    private var monsters: FetchedResults<Monster>

    var body: some View {
//        var body: some View {
//            TextEditor(text: $document.text)
//        }

        List {
            ForEach(monsters) { monster in
                Text("Monster:  \(monster.name!)")
            }
            .onDelete(perform: deleteMonsters)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addMonster) {
                Label("Add Monster", systemImage: "plus")
            }
        }
    }

    private func addMonster() {
        withAnimation {
            let newMonster = Monster(context: viewContext)

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
            offsets.map { monsters[$0] }.forEach(viewContext.delete)

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
    static var previews: some View {
        ContentView(document: .constant(SummonerJsonDocument()))
    }
}
