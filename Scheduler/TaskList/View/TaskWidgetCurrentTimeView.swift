//
//  TaskWidgetCurrentTimeView.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetCurrentTimeView: UICollectionReusableView {

    // MARK: - Views

    private let indicator = Indicator()

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        guard superview != nil else {
            return
        }
        addSubview(indicator)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.frame = bounds
    }
}
