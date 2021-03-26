//
//  ProgressNode.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 26.03.2021.
//

import UIKit

extension ProgressView {

    // MARK: Nested Types

    final class Node: UIView {

        // MARK: - Views

        private let borderLayer = CAShapeLayer()
        private let circleLayer = CAShapeLayer()

        // MARK: - Properties

        var animationDuration: TimeInterval = 0.35
        var fillColor: UIColor?

        // MARK: - Private properties

        private var state: State = .initial

        // MARK: - Lifecycle

        override func didMoveToSuperview() {
            guard superview != nil else {
                return
            }
            setup()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            let borderRadius = min(bounds.width * 0.5, bounds.height * 0.5)
            let lineWidth = borderRadius * 0.25
            let circleRadius = borderRadius - 2 * lineWidth
            let arcCenter = CGPoint(
                x: bounds.midX,
                y: bounds.minY
            )
            circleLayer.path = UIBezierPath(
                arcCenter: arcCenter,
                radius: circleRadius,
                startAngle: .zero,
                endAngle: .pi * 2.0,
                clockwise: true
            ).cgPath
            borderLayer.path = UIBezierPath(
                arcCenter: arcCenter,
                radius: borderRadius,
                startAngle: .zero,
                endAngle: .pi * 2.0,
                clockwise: true
            ).cgPath
            circleLayer.lineWidth = lineWidth
            borderLayer.lineWidth = lineWidth
        }

        // MARK: - Functions

        func update(to newState: State, animated: Bool) {
            guard state != newState else { return }
            let duration = animated ? animationDuration : .zero
            let borderOpacity: CGFloat = newState == .complete ? 1.0 : 0.0
            let circleColor = newState == .complete ? fillColor : backgroundColor
            let borderAnimation = opacityAnimation(
                toValue: borderOpacity,
                duration: duration
            )
            let circleAnimation = fillColorAnimation(
                toValue: circleColor,
                duration: duration
            )
            borderLayer.removeAllAnimations()
            circleLayer.removeAllAnimations()
            borderLayer.add(borderAnimation, forKey: nil)
            circleLayer.add(circleAnimation, forKey: nil)
            state = newState
        }

        // MARK: - Private functions

        private func setup() {
            backgroundColor = .white
            borderLayer.lineWidth = 2.0
            borderLayer.strokeColor = fillColor?.cgColor
            borderLayer.opacity = state == .complete ? 1 : 0
            borderLayer.fillColor = backgroundColor?.cgColor
            circleLayer.lineWidth = 2.0
            circleLayer.strokeColor = fillColor?.cgColor
            circleLayer.fillColor = state == .complete ? fillColor?.cgColor : backgroundColor?.cgColor
            layer.addSublayer(borderLayer)
            layer.addSublayer(circleLayer)
        }

        private func fillColorAnimation(toValue: UIColor?, duration: TimeInterval) -> CAAnimation {
            let colorAnimation = CABasicAnimation(keyPath: "fillColor")
            colorAnimation.toValue = toValue?.cgColor
            colorAnimation.isRemovedOnCompletion = false
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            colorAnimation.fillMode = .forwards
            colorAnimation.duration = duration

            return colorAnimation
        }

        private func opacityAnimation(toValue: CGFloat, duration: TimeInterval) -> CAAnimation {
            let colorAnimation = CABasicAnimation(keyPath: "opacity")
            colorAnimation.toValue = toValue
            colorAnimation.isRemovedOnCompletion = false
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            colorAnimation.fillMode = .forwards
            colorAnimation.duration = duration

            return colorAnimation
        }
    }

}
