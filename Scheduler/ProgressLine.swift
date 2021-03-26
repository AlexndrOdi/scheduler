//
//  ProgressLine.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 26.03.2021.
//

import UIKit

extension ProgressView {

    // MARK: - Nested Types

    final class Line: UIView {

        // MARK: - Views

        private let lineLayer = CAShapeLayer()

        // MARK: - Properties

        var fillColor: UIColor?

        // MARK: - Lifecycle

        override func didMoveToSuperview() {
            guard superview != nil else {
                return
            }
            setup()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            lineLayer.frame = bounds
            lineLayer.path = UIBezierPath(rect: bounds).cgPath
        }

        // MARK: - Private functions

        private func setup() {
            lineLayer.strokeColor = fillColor?.cgColor
            lineLayer.fillColor = fillColor?.cgColor
            layer.addSublayer(lineLayer)
        }
    }
}
