//
//  CoinTrackerApp.swift
//  CoinTracker
//
//  Created by Jan Klanica on 20.04.2024.
//

import SwiftUI

@main
struct CoinTrackerApp: App {
    @StateObject var appAlert = AppAlert.shared
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert(isPresented: $appAlert.isPresented,
                       content: { appAlert.alert! }
                )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
