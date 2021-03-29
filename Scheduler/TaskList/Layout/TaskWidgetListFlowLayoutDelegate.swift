//
//  TaskWidgetListFlowLayoutDelegate.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

protocol TaskWidgetListFlowLayoutDelegate: AnyObject {

    // MARK: - Functions

    func flowLayout(
        _ flowLayout: TaskWidgetListFlowLayout,
        sizeForWidgetAt indexPath: IndexPath,
        with textInsets: WidgetTextInsets,
        prefferedWidth: CGFloat
    ) -> CGSize
}
