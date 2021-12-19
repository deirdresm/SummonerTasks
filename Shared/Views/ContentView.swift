//
//  ContentView.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    @State var runeType: RuneType? = RuneType.violent
    @Binding var document: SummonerJsonDocument
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
        NavigationView {
            VStack {
                SummonerName(summoner: document.docInfo.summoner, prefix: "Hello, ", suffix: ".")
                RuneSidebar(document: document, selection: $runeType)
            }
            RuneList(docInfo: document.docInfo)
            Spacer()
        }
        .padding()
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
    static let text = Bundle.main.openBundleFile(from: "runes-mini.json")
    static var document: SummonerJsonDocument = {
        return try! SummonerJsonDocument(text: text, summoner: Summoner.tisHerself, isPreview: true)
    }()
    
    static var previews: some View {
        ContentView(document: .constant(document))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
