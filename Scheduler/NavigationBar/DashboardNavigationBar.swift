//
//  DashboardNavigationBar.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 30.03.2021.
//

import UIKit

protocol DashboardNavigationBarDelegate: AnyObject {

    // MARK: - Functions

    func navigationBarDidTapAddButton(_ navigationBar: DashboardNavigationBar)
}

fileprivate protocol DashboardNavigationBarConteViewDelegate: AnyObject {

    // MARK: - Functions

    func contentViewDidTapAddButton(_ navigationBar: DashboardNavigationBar.ContentView)
}

extension DashboardNavigationBar {
    final class ContentView: UIView {

        // MARK: - Nested Types

        typealias Animation = () -> Void
        typealias Completion = (UIViewAnimatingPosition) -> Void

        enum State {
            case small, full
        }

        // MARK: - Properties

        var animationDuration: TimeInterval = 5
        var animationTiming: UITimingCurveProvider = UICubicTimingParameters(animationCurve: .linear)
        private(set) var state: State = .full

        var attributedTitle: NSAttributedString? {
            get { titleLabel.attributedText }
            set { titleLabel.attributedText = newValue }
        }

        var attributedSubtitle: NSAttributedString? {
            get { subtitleLabel.attributedText }
            set { subtitleLabel.attributedText = newValue }
        }

        // MARK: - Views

        private let addButton = ActionButton(kind: .add)
        private let titleLabel = UILabel()
        private let subtitleLabel = UILabel()

        // MARK: - Private properties

        fileprivate weak var delegate: DashboardNavigationBarConteViewDelegate?
        private var animator: UIViewPropertyAnimator?

        // MARK: - Lifecycle

        override func didMoveToSuperview() {
            guard superview != nil else {
                return
            }
            setup()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            let buttonSize = addButton.sizeThatFits(.zero)
            addButton.frame = CGRect(
                x: bounds.width - buttonSize.width,
                y: bounds.height - buttonSize.height,
                width: ceil(buttonSize.width),
                height: ceil(buttonSize.height)
            )
            let sizeToFit = CGSize(
                width: bounds.width - addButton.bounds.width,
                height: .greatestFiniteMagnitude
            )
            let titleSize = titleLabel.sizeThatFits(sizeToFit)
            titleLabel.frame = CGRect(
                x: .zero,
                y: bounds.height - titleSize.height,
                width: ceil(titleSize.width),
                height: ceil(titleSize.height)
            )
            let subtitleSize = subtitleLabel.sizeThatFits(sizeToFit)
            subtitleLabel.frame = CGRect(
                x: .zero,
                y: bounds.height - titleSize.height - subtitleSize.height,
                width: ceil(subtitleSize.width),
                height: ceil(subtitleSize.height)
            )
        }

        // MARK: - Functions

        func startAnimation(to state: State) {
            guard self.state != state else {
                return
            }
            stopAnimation(withoutFinishing: true)
            animator = setupAnimator(
                with: [
                    buttonAnimation(to: state),
                    titleAnimation(to: state),
                    subtitleAnimation(to: state)
                ],
                completion: animationCompletion(to: state)
            )
            animator?.startAnimation()
        }

        func pauseAnimation() {
            animator?.pauseAnimation()
        }

        func continueAnimation(
            withTimingParameters timigProvider: UITimingCurveProvider,
            durationFactor: CGFloat
        ) {
            animator?.continueAnimation(
                withTimingParameters: timigProvider,
                durationFactor: durationFactor
            )
        }

        func updateAnimation(fraction: CGFloat) {
            animator?.fractionComplete = fraction
        }

        func stopAnimation(withoutFinishing: Bool) {
            animator?.stopAnimation(withoutFinishing)
        }

        func finishAnimation(at position: UIViewAnimatingPosition) {
            animator?.finishAnimation(at: position)
        }

        // MARK: - Private functions

        private func setup() {
            addButton.addTarget(
                self,
                action: #selector(didTapAddButton),
                for: .touchUpInside
            )
            addSubview(addButton)
            addSubview(titleLabel)
            addSubview(subtitleLabel)
        }

        @objc private func didTapAddButton() {
            delegate?.contentViewDidTapAddButton(self)
        }

        private func setupAnimator(
            with animations: [Animation],
            completion: @escaping Completion
        ) -> UIViewPropertyAnimator {
            let animator = UIViewPropertyAnimator(
                duration: animationDuration,
                timingParameters: animationTiming
            )
            animations.forEach { animator.addAnimations($0) }
            animator.addCompletion(completion)

            return animator
        }

        private func buttonAnimation(to state: State) -> Animation {
            return { [unowned self] in
                self.addButton.transform = state == .full ?
                    .identity :
                    CGAffineTransform(
                        scaleX: 0.1,
                        y: 0.1
                    )
            }
        }

        private func titleAnimation(to state: State) -> Animation {
            return { [unowned self] in
                self.titleLabel.transform = state == .full ?
                    .identity :
                    CGAffineTransform(
                        scaleX: 0.1,
                        y: 0.1
                    )
            }
        }

        private func subtitleAnimation(to state: State) -> Animation {
            return { [unowned self] in
                self.subtitleLabel.transform = state == .full ?
                    .identity :
                    CGAffineTransform(
                        scaleX: 0.1,
                        y: 0.1
                    )
            }
        }

        private func animationCompletion(to state: State) -> Completion {
            return { [weak self] position in
                if case .end = position {
                    self?.state = state
                }
            }
        }
    }
}

final class DashboardNavigationBar: UIView {

    // MARK: - Views

    private let contentView = ContentView()

    // MARK: - Properties

    var contentInsets: UIEdgeInsets = .zero

    weak var delegate: DashboardNavigationBarDelegate?

    weak var scrollView: UIScrollView? {
        didSet {
            oldValue?.panGestureRecognizer.removeTarget(
                self,
                action: #selector(handlePan(_:))
            )
            scrollView?.panGestureRecognizer.addTarget(
                self,
                action: #selector(handlePan(_:))
            )
        }
    }

    var attributedTitle: NSAttributedString? {
        get { contentView.attributedTitle }
        set { contentView.attributedTitle = newValue }
    }

    var attributedSubtitle: NSAttributedString? {
        get { contentView.attributedSubtitle }
        set { contentView.attributedSubtitle = newValue }
    }

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        guard superview != nil else {
            return
        }
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds.inset(by: contentInsets)
    }

    // MARK: - Private functions

    private func setup() {
        backgroundColor = .white
        addSubview(contentView)
    }

    @objc private func handlePan(_ panRecognizer: UIPanGestureRecognizer) {

    }
}
