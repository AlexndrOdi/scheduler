//
//  TaskWidget.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

protocol Configurable {

    // MARK: - Constants

    associatedtype Model

    // MARK: - Functions

    func configure(model: Model)
}

protocol TaskWidgetDelegate: AnyObject {

    // MARK: - Functions

    func taskWidgetDidTapDoneButton(_ widget: TaskWidget)
}

final class TaskWidget: UICollectionViewCell {

    // MARK: - Views

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let timeIntervalLabel = UILabel()
    private let doneButton = ActionButton(kind: .done)

    // MARK: - Properties

    weak var delegate: TaskWidgetDelegate?

    // MARK: - Private properties

    private var textInsets: WidgetTextInsets = .zero

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
        textInsets = attributes.textInsets
        contentView.layer.cornerRadius = attributes.cornerRadius
        contentView.layer.maskedCorners = CACornerMask(rawValue: attributes.roundedCorners.rawValue)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTimeIntervalLabel()
        layoutTitleLabel()
        layoutDescriptionLabel()
        layoutDoneButton()
    }

    // MARK: - Functions

    func configure(task: ITask) {
        titleLabel.attributedText = task.title
        descriptionLabel.attributedText = task.description
        timeIntervalLabel.attributedText = task.timeIntreval
        contentView.backgroundColor = task.isSelected ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) : .white
    }

    // MARK: - Private functions

    private func setup() {
        contentView.layer.masksToBounds = true
        titleLabel.numberOfLines = .zero
        contentView.addSubview(titleLabel)
        descriptionLabel.numberOfLines = .zero
        contentView.addSubview(descriptionLabel)
        timeIntervalLabel.numberOfLines = .zero
        contentView.addSubview(timeIntervalLabel)
        doneButton.addTarget(
            self,
            action: #selector(didTapDoneButton),
            for: .touchUpInside
        )
        contentView.addSubview(doneButton)
    }

    @objc private func didTapDoneButton() {
        delegate?.taskWidgetDidTapDoneButton(self)
    }

    private func layoutTitleLabel() {
        let sizeToFit = CGSize(
            width: contentView.bounds.width - textInsets.titleInsets.horizontal - textInsets.timeIntervalInsets.horizontal - timeIntervalLabel.bounds.width,
            height: .greatestFiniteMagnitude
        )
        let size = titleLabel.sizeThatFits(sizeToFit)
        titleLabel.frame = CGRect(
            x: textInsets.titleInsets.left,
            y: textInsets.titleInsets.top,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }

    private func layoutDescriptionLabel() {
        let sizeToFit = CGSize(
            width: contentView.bounds.width - textInsets.descriptionInsets.horizontal,
            height: .greatestFiniteMagnitude
        )
        let size = descriptionLabel.sizeThatFits(sizeToFit)
        descriptionLabel.frame = CGRect(
            x: textInsets.descriptionInsets.left,
            y: textInsets.descriptionInsets.top + titleLabel.frame.maxY,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }

    private func layoutTimeIntervalLabel() {
        let sizeToFit = CGSize(
            width: contentView.bounds.width - textInsets.timeIntervalInsets.horizontal - textInsets.titleInsets.horizontal,
            height: .greatestFiniteMagnitude
        )
        let size = timeIntervalLabel.sizeThatFits(sizeToFit)
        timeIntervalLabel.frame = CGRect(
            x: ceil(contentView.bounds.width - textInsets.timeIntervalInsets.right - size.width),
            y: textInsets.timeIntervalInsets.top,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }

    private func layoutDoneButton() {
        let sizeToFit = CGSize(
            width: contentView.bounds.width - textInsets.descriptionInsets.horizontal - textInsets.doneButtonInsets.horizontal,
            height: .greatestFiniteMagnitude
        )
        let size = doneButton.sizeThatFits(sizeToFit)
        doneButton.frame = CGRect(
            x: ceil(contentView.bounds.width - size.width - textInsets.doneButtonInsets.right),
            y: descriptionLabel.frame.maxY + textInsets.doneButtonInsets.top,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }
}
