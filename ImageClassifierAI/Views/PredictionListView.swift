//
//  PredictionListView.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import SwiftUI
import SwiftData

struct PredictionListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \PredictionResult.createdAt, order: .reverse) private var predictions: [PredictionResult]

    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(predictions) { prediction in
                    PredictionRowView(prediction: prediction)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(predictions[index])
                    }
                }
            }
            .navigationTitle("Predictions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Pick Image") {
                        showImagePicker = true
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .onChange(of: selectedImage) {
                if let image = selectedImage {
                    classifyAndSave(image: image)
                }
            }
        }
    }

    // Tahmin ve kayıt fonksiyonu
    func classifyAndSave(image: UIImage) {
        print("🧪 Görsel alındı, işleniyor...")

        let classifier = ImageClassifier()
        let result = classifier.classify(image: image)

        if let savedFileName = ImageStorage.saveImage(image) {
            let newEntry = PredictionResult(
                imageName: savedFileName,
                prediction: result
            )
            context.insert(newEntry)
            print("✅ Kayıt eklendi: \(savedFileName)")
        } else {
            print("❌ Görsel kaydedilemedi.")
        }
    }
}
