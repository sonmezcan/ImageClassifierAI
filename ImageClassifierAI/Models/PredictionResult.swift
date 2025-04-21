//
//  PredictionResult.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import Foundation
import SwiftData

@Model
class PredictionResult {
    var imageName: String
    var prediction: String
    var createdAt: Date

    init(imageName: String, prediction: String, createdAt: Date = Date()) {
        self.imageName = imageName
        self.prediction = prediction
        self.createdAt = createdAt
    }
}
