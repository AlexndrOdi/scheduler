//
//  ITaskWidgetSizeCalculator.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

protocol ITaskWidgetSizeCalculator: AnyObject {

    // MARK: - Functions

    func size(
        for task: ITask,
        with prefferedWidth: CGFloat,
        textInsets: WidgetTextInsets
    ) -> CGSize
}
