//
//  ImageClassifierAIApp.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import SwiftUI
import SwiftData

@main
struct ImageClassifierAIApp: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([PredictionResult.self])
        let modelConfiguration = ModelConfiguration("AIImageClassifier.sqlite", isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer) // ✅ Artık doğru container kullanılıyor
    }
}
