# 🧠 AI-Powered Image Classifier (SwiftUI + CoreML)

This iOS application allows users to select an image and uses Apple's CoreML technology to classify what's inside the image using the MobileNetV2 model. The results are stored locally using SwiftData and displayed in an expandable card layout.

## 📱 Preview
<!-- Insert a screenshot or gif here -->
<!-- ![App Screenshot](screenshot.png) -->

## 🚀 Features

- SwiftUI-based modern interface
- Image classification using CoreML (MobileNetV2)
- Persistent storage of classification results with SwiftData
- Expandable prediction cards with thumbnails and full-size images
- Image selection using a native photo picker
- Local image storage using FileManager

## 🧠 Core ML Model Info

- **Model**: MobileNetV2
- **Source**: [Apple Core ML Gallery](https://developer.apple.com/machine-learning/models/)
- **Input**: Image (224x224)
- **Output**: classLabel (top-1 prediction)

