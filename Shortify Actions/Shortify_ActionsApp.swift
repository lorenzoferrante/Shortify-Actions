//
//  Shortify_ActionsApp.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import SwiftUI

@main
struct Shortify_ActionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
