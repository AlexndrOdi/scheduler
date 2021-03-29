//
//  TaskWidgetTimeView.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetTimeView: UICollectionReusableView {

    // MARK: - Views

    private let timeLabel = UILabel()

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        guard superview != nil else {
            return
        }
        setup()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let startOfDay = Calendar.current.startOfDay(for: Date())
        guard let date = Calendar.current.date(
            byAdding: .hour,
            value: layoutAttributes.indexPath.item,
            to: startOfDay
        )
        else { return super.apply(layoutAttributes) }
        timeLabel.text = timeFormatter.string(from: date)
        super.apply(layoutAttributes)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        timeLabel.frame = bounds
    }

    // MARK: - Private functions

    private func setup() {
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
    }
}
