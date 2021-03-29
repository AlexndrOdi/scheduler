//
//  WidgetTextInsets.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

struct WidgetTextInsets {

    // MARK: - Properties

    let titleInsets: UIEdgeInsets
    let descriptionInsets: UIEdgeInsets
    let timeIntervalInsets: UIEdgeInsets
    let doneButtonInsets: UIEdgeInsets
}

extension WidgetTextInsets {
    static let zero = WidgetTextInsets(
        titleInsets: .zero,
        descriptionInsets: .zero,
        timeIntervalInsets: .zero,
        doneButtonInsets: .zero
    )
}

extension WidgetTextInsets: Equatable { }
