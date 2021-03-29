//
//  ActionButton.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

final class ActionButton: UIButton {

    // MARK: - Constants

    private struct Constants {
        struct TouchAnimationParameters {
            let duration: TimeInterval
            let scale: CGFloat
            let timingFunction: CAMediaTimingFunctionName
        }
        static let touchDownParameters = TouchAnimationParameters(
            duration: 0.15,
            scale: 0.95,
            timingFunction: .easeIn
        )
        static let touchCancelParameters = TouchAnimationParameters(
            duration: 0.1,
            scale: 1.0,
            timingFunction: .easeOut
        )
        static let cornerRadius: CGFloat = 8.0
        static let prefferedSize = CGSize(width: 56.0, height: 56.0)
    }

    // MARK: - Nested Types

    enum Kind {
        case add, done
    }

    // MARK: - Properties

    let kind: Kind

    // MARK: - Private properties

    private let markLayer = CAShapeLayer()

    // MARK: - Initialization

    init(
        frame: CGRect = .zero,
        kind: Kind
    ) {
        self.kind = kind
        super.init(frame: frame)
        setupAppearance()
        setupInteractions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("ActionButton ::: init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let transaform = CGAffineTransform(
            scaleX: 1 + titleEdgeInsets.horizontal / Constants.prefferedSize.width,
            y: 1 + titleEdgeInsets.vertical / Constants.prefferedSize.height
        )
        return Constants.prefferedSize.applying(transaform)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constants.cornerRadius
        markLayer.path = markLayerPath()
    }

    // MARK: - Private functions

    private func setupAppearance() {
        layer.masksToBounds = true
        setBackgroundColor(#colorLiteral(red: 0, green: 0.1040571257, blue: 0.1882568598, alpha: 1), for: .normal)
        setupMarkLayer()
    }

    private func setupMarkLayer() {
        markLayer.strokeColor = UIColor.white.cgColor
        markLayer.lineWidth = 2.5
        markLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(markLayer)
    }

    private func markLayerPath() -> CGPath {
        let path = UIBezierPath()
        switch kind {
        case .add:
            path.move(
                to: CGPoint(
                    x: bounds.midX - 9,
                    y: bounds.midY
                )
            )
            path.addLine(
                to: CGPoint(
                    x: bounds.midX + 9,
                    y: bounds.midY
                )
            )
            path.move(
                to: CGPoint(
                    x: bounds.midX,
                    y: bounds.midY - 9
                )
            )
            path.addLine(
                to: CGPoint(
                    x: bounds.midX,
                    y: bounds.midY + 9
                )
            )
        case .done:
            path.move(
                to: CGPoint(
                    x: bounds.midX - 7,
                    y: bounds.midY - 1
                )
            )
            path.addLine(
                to: CGPoint(
                    x: bounds.midX - 2,
                    y: bounds.midY + 5
                )
            )
            path.addLine(
                to: CGPoint(
                    x: bounds.midX + 10,
                    y: bounds.midY - 8
                )
            )
        }
        return path.cgPath
    }

    private func setupInteractions() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        addTarget(self, action: #selector(touchCancel), for: .touchUpInside)
        addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
        addTarget(self, action: #selector(touchDown), for: .touchDragEnter)
        addTarget(self, action: #selector(touchCancel), for: .touchDragExit)
    }

    @objc private func touchDown() {
        let animation = scaleAnimation(
            scaleValue: Constants.touchDownParameters.scale,
            duration: Constants.touchDownParameters.duration,
            timingName: Constants.touchDownParameters.timingFunction
        )
        layer.add(animation, forKey: nil)
    }

    @objc private func touchCancel() {
        let animation = scaleAnimation(
            scaleValue: Constants.touchCancelParameters.scale,
            duration: Constants.touchCancelParameters.duration,
            timingName: Constants.touchCancelParameters.timingFunction
        )
        layer.add(animation, forKey: nil)
    }

    private func scaleAnimation(
        scaleValue: Any?,
        duration: CFTimeInterval,
        timingName: CAMediaTimingFunctionName
    ) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = scaleValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: timingName)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        return animation
    }
}
