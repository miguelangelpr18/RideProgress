//
//  YearSummaryRenderer.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import UIKit

protocol YearSummaryRenderer {
    func renderSlides(summary: YearSummary) -> [UIImage]
}

final class YearSummaryRendererImpl: YearSummaryRenderer {
    func renderSlides(summary: YearSummary) -> [UIImage] {
        // TODO(Fase 3): Reemplazar con renderizado real basado en templates SwiftUI.
        let size = CGSize(width: 1080, height: 1920)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            let bounds = CGRect(origin: .zero, size: size)
            UIColor.systemIndigo.setFill()
            context.fill(bounds)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 96),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]

            let text = "Resumen \(summary.year)\n(stub)"
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            let textRect = CGRect(x: 40, y: bounds.midY - 120, width: bounds.width - 80, height: 240)
            attributedText.draw(in: textRect)
        }

        return [image]
    }
}

