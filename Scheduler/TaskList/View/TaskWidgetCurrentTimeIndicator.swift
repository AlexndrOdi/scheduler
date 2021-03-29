//
//  TaskWidgetCurrentTimeIndicator.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

extension TaskWidgetCurrentTimeView {
    final class Indicator: UIView {

        // MARK: - Views

        private let line = CAShapeLayer()

        // MARK: - Lifecycle

        override func didMoveToSuperview() {
            guard superview != nil else {
                return
            }
            setup()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: .zero, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
            line.path = path.cgPath
        }

        // MARK: - Private functions

        private func setup() {
            line.strokeColor = UIColor.red.cgColor
            line.lineWidth = 2
            line.lineCap = .round
            layer.addSublayer(line)
        }
    }
}
