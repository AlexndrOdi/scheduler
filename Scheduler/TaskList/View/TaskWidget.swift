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

final class TaskWidget: UIView {

    // MARK: - Views

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let timeIntervalLabel = UILabel()
    private let doneButton = ActionButton(kind: .done)
    private let progressView = ProgressView()

    // MARK: - Properties

    weak var delegate: TaskWidgetDelegate?

    // MARK: - Private properties

    var textInsets: WidgetTextInsets = .zero {
        didSet {
            setNeedsLayout()
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
        layoutTimeIntervalLabel()
        layoutTitleLabel()
        layoutDescriptionLabel()
        layoutDoneButton()
    }

    // MARK: - Functions

    func configure(task: ITask) {
        titleLabel.attributedText = applyTextColor(
            #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1),
            for: task.title
        )
        descriptionLabel.attributedText = applyTextColor(
            task.isSelected ? #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1) : #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1),
            for: task.description
        )
        timeIntervalLabel.attributedText = applyTextColor(
            task.isSelected ? #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1) : #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1),
            for: task.timeIntreval
        )
        backgroundColor = task.isSelected ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) : .white
    }

    // MARK: - Private functions

    private func applyTextColor(_ color: UIColor, for attributedText: NSAttributedString?) -> NSAttributedString? {
        guard let attributedString = attributedText else {
            return nil
        }


        let attrText = NSMutableAttributedString(attributedString: attributedString)
        attrText.addAttribute(
            .foregroundColor,
            value: color,
            range: (attrText.string as NSString).range(of: attrText.string)
        )

        return attrText
    }

    private func setup() {
        layer.masksToBounds = true
        titleLabel.numberOfLines = .zero
        addSubview(titleLabel)
        descriptionLabel.numberOfLines = .zero
        addSubview(descriptionLabel)
        timeIntervalLabel.numberOfLines = .zero
        addSubview(timeIntervalLabel)
        doneButton.addTarget(
            self,
            action: #selector(didTapDoneButton),
            for: .touchUpInside
        )
        addSubview(doneButton)
    }

    @objc private func didTapDoneButton() {
        delegate?.taskWidgetDidTapDoneButton(self)
    }

    private func layoutTitleLabel() {
        let sizeToFit = CGSize(
            width: bounds.width - textInsets.titleInsets.horizontal - textInsets.timeIntervalInsets.horizontal - timeIntervalLabel.bounds.width,
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
            width: bounds.width - textInsets.descriptionInsets.horizontal,
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
            width: bounds.width - textInsets.timeIntervalInsets.horizontal - textInsets.titleInsets.horizontal,
            height: .greatestFiniteMagnitude
        )
        let size = timeIntervalLabel.sizeThatFits(sizeToFit)
        timeIntervalLabel.frame = CGRect(
            x: ceil(bounds.width - textInsets.timeIntervalInsets.right - size.width),
            y: textInsets.timeIntervalInsets.top,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }

    private func layoutDoneButton() {
        let sizeToFit = CGSize(
            width: bounds.width - textInsets.descriptionInsets.horizontal - textInsets.doneButtonInsets.horizontal,
            height: .greatestFiniteMagnitude
        )
        let size = doneButton.sizeThatFits(sizeToFit)
        doneButton.frame = CGRect(
            x: ceil(bounds.width - size.width - textInsets.doneButtonInsets.right),
            y: descriptionLabel.frame.maxY + textInsets.doneButtonInsets.top,
            width: ceil(size.width),
            height: ceil(size.height)
        )
    }
}
