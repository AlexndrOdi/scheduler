//
//  ProgressView.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 26.03.2021.
//

import UIKit

final class ProgressView: UIView {

    // MARK: - Nested Types

    enum State {
        case complete, initial
    }

    // MARK: - Views

    private let node = Node()
    private let line = Line()

    // MARK: - Properties

    var fillColor: UIColor? {
        didSet {
            node.fillColor = fillColor
            line.fillColor = fillColor
        }
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
        node.frame = CGRect(
            x: .zero,
            y: .zero,
            width: bounds.width,
            height: bounds.width
        )
        let lineWidth = bounds.width * 0.1
        line.frame = CGRect(
            x: node.bounds.midX - lineWidth * 0.5,
            y: bounds.width,
            width: lineWidth,
            height: bounds.height - bounds.width
        )
    }

    // MARK: - Functions

    func update(to newState: State, animated: Bool) {
        node.update(to: newState, animated: animated)
    }

    // MARK: - Private functions

    private func setup() {
        addSubview(node)
        addSubview(line)
    }
}
