//
//  TaskWidgetViewCellDelegate.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 29.03.2021.
//

import UIKit

protocol TaskWidgetViewCellDelegate: AnyObject {

    // MARK: - Functions

    func widgetCellDidTapDoneButton(_ cell: TaskWidgetViewCell)
}
