//
//  ArtifactSummary.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/21/21.
//

import SwiftUI
import CoreData

struct ArtifactSummaryView: View {
    @Binding var document: SummonerJsonDocument
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: ArtifactInstance.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \ArtifactInstance.slot, ascending: true),
            NSSortDescriptor(keyPath: \ArtifactInstance.element, ascending: true)
        ]) var artifactCounts: FetchedResults<ArtifactInstance>

    @State var lastArtifactType = -1
    @State var lastArtifactElement = -1

    private var lastTitle = ""

    // grid placeholder
    let columns: [GridItem] = [
        GridItem(.fixed(116)),
        GridItem(.fixed(116)),
        GridItem(.fixed(116))
    ]

    // for artifacts, sort by slot and then archetype


    var body: some View {
        NavigationView {
            VStack {

            }
        }
    }
}
