//
//  eterationcaseApp.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

@main
struct eterationcaseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
