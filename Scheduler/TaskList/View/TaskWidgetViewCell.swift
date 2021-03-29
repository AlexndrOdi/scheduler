//
//  TaskWidgetViewCell.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 29.03.2021.
//

import UIKit

final class TaskWidgetViewCell: UICollectionViewCell {

    // MARK: - Views

    private let widget = TaskWidget()
    private let progressView = ProgressView()

    // MARK: - Properties

    weak var delegate: TaskWidgetViewCellDelegate?

    // MARK: - Private properties

    private var progressViewInsets: UIEdgeInsets = .zero

    // MARK: - Initialization

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        guard superview != nil else {
            return
        }
        setup()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? TaskWidgetLayoutAttributes else {
            return
        }
        progressViewInsets = attributes.progressViewInsets
        widget.textInsets = attributes.textInsets
        widget.layer.cornerRadius = attributes.cornerRadius
        widget.layer.maskedCorners = CACornerMask(rawValue: attributes.roundedCorners.rawValue)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutProgressView()
        layoutWidget()
    }

    // MARK: - Functions

    func configure(task: ITask) {
        widget.configure(task: task)
        progressView.update(
            to: task.isCompleted ? .complete : .initial,
            animated: true
        )
    }

    // MARK: - Private functions

    private func setup() {
        widget.delegate = self
        contentView.addSubview(widget)
        progressView.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        contentView.addSubview(progressView)
    }

    private func layoutProgressView() {
        progressView.frame = CGRect(
            x: progressViewInsets.left,
            y: progressViewInsets.top,
            width: 15.0,
            height: contentView.bounds.height - progressViewInsets.vertical
        )
    }

    private func layoutWidget() {
        widget.frame = CGRect(
            x: progressView.frame.maxX + progressViewInsets.right,
            y: progressViewInsets.top,
            width: contentView.bounds.width - progressView.bounds.width - progressViewInsets.horizontal,
            height: contentView.bounds.height - progressViewInsets.vertical
        )
    }
}

// MARK: - TaskWidgetDelegate

extension TaskWidgetViewCell: TaskWidgetDelegate {
    func taskWidgetDidTapDoneButton(_ widget: TaskWidget) {
        delegate?.widgetCellDidTapDoneButton(self)
    }
}
