//
//  PredictionRowView.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import SwiftUI
import SwiftData



struct PredictionRowView: View {
    let prediction: PredictionResult
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let image = ImageStorage.loadImage(named: prediction.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        .clipped()
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("🔍 \(prediction.prediction)")
                        .font(.headline)
                    Text("🕒 \(prediction.createdAt.formatted())")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                Divider().padding(.vertical, 4)
                if let image = ImageStorage.loadImage(named: prediction.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                }

                Text("📁 Dosya adı: \(prediction.imageName)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
            }
        }
        .padding(.vertical, 6)
    }
}
