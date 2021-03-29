//
//  TaskWidgetLayoutAttributes.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetLayoutAttributes: UICollectionViewLayoutAttributes {

    // MARK: - Properties

    var textInsets: WidgetTextInsets = .zero
    var roundedCorners: UIRectCorner = .allCorners
    var cornerRadius: CGFloat = .zero

    // MARK: - Initialization

    convenience init(
        element: TaskWidgetListFlowLayout.Element,
        with indexPath: IndexPath
    ) {
        switch element {
        case .widget:
            self.init(forCellWith: indexPath)
        }
    }

    // MARK: - Functions

    override func copy() -> Any {
        guard let attr = super.copy() as? TaskWidgetLayoutAttributes else {
            return super.copy()
        }

        attr.roundedCorners = self.roundedCorners
        attr.textInsets = self.textInsets
        attr.cornerRadius = self.cornerRadius
        return attr
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let attr = object as? TaskWidgetLayoutAttributes else {
            return super.isEqual(object)
        }

        return attr.cornerRadius == self.cornerRadius
            && attr.roundedCorners == self.roundedCorners
            && attr.textInsets == self.textInsets
            && super.isEqual(object)
    }
}
