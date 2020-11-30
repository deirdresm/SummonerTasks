//
//  SummonerTasksApp.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import SwiftUI

@main
struct SummonerTasksApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: SummonerTasksDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
