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

    // MARK: - Enums

    enum Kind {
        case add, done
    }

    let kind: Kind

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
        switch kind {
        case .add:
            let transaform = CGAffineTransform(
                scaleX: 1 + titleEdgeInsets.horizontal / Constants.prefferedSize.width,
                y: 1 + titleEdgeInsets.vertical / Constants.prefferedSize.height
            )
            return Constants.prefferedSize.applying(transaform)
        case .done:
            let size = attributedTitle(for: .normal)?.boundingRect(
                with: size,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            ).integral.size  ?? Constants.prefferedSize
            let transaform = CGAffineTransform(
                scaleX: 1 + titleEdgeInsets.horizontal / size.width,
                y: 1 + titleEdgeInsets.vertical / size.height
            )
            return size.applying(transaform)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constants.cornerRadius
    }

    // MARK: - Private functions

    private func setupAppearance() {
        layer.masksToBounds = true
        setBackgroundColor(#colorLiteral(red: 0, green: 0.1040571257, blue: 0.1882568598, alpha: 1), for: .normal)
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

extension ActionButton.Kind {
    var attributedText: NSAttributedString {
        switch self {
        case .add:
            return NSAttributedString(string: "add")
        case .done:
            return NSAttributedString(string: "done")
        }
    }
}
