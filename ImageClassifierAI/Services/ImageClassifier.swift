//
//  ImageClassifier.swift
//  ImageClassifierAI
//
//  Created by can on 21.04.2025.
//

import Foundation
import CoreML
import UIKit
import CoreVideo

class ImageClassifier {
    private let model: MobileNetV2

    init() {
        // Modelin yüklenmesini deniyoruz
        do {
            self.model = try MobileNetV2(configuration: MLModelConfiguration())
        } catch {
            fatalError("Model yüklenemedi: \(error.localizedDescription)")
        }
    }

    func classify(image: UIImage) -> String {
        // Görseli pixel buffer'a dönüştür
        guard let pixelBuffer = image.resizeTo(size: CGSize(width: 224, height: 224))?.toCVPixelBuffer() else {
            return "Görsel dönüştürülemedi"
        }

        do {
            let output = try model.prediction(image: pixelBuffer)
            return output.classLabel
        } catch {
            return "Tahmin yapılamadı: \(error.localizedDescription)"
        }
    }
}

struct ImageStorage {
    static func saveImage(_ image: UIImage) -> String? {
        let filename = UUID().uuidString + ".jpg"
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }

        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("❌ Görsel kaydedilemedi: \(error)")
            return nil
        }
    }

    static func loadImage(named filename: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }

    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }

    func toCVPixelBuffer() -> CVPixelBuffer? {
        let width = Int(self.size.width)
        let height = Int(self.size.height)

        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ] as CFDictionary

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32ARGB,
            attrs,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(
            data: CVPixelBufferGetBaseAddress(buffer),
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        ) else {
            return nil
        }

        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()

        CVPixelBufferUnlockBaseAddress(buffer, [])

        return buffer
    }
}
