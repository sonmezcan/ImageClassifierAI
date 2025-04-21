//
//  ModelContainerProvider.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import SwiftData

struct ModelContainerProvider {
    static let shared: ModelContainer = {
        do {
            let schema = Schema([PredictionResult.self])
            let config = ModelConfiguration("AIImageClassifier.sqlite") // disk dosyası adı
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("❌ SwiftData container yüklenemedi: \(error)")
        }
    }()
}
