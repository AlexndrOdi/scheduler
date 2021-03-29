//
//  TaskWidgetSizeCalculator.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetSizeCalculator: ITaskWidgetSizeCalculator {

    // MARK: - Functions

    func size(
        for task: ITask,
        with prefferedWidth: CGFloat,
        textInsets: WidgetTextInsets
    ) -> CGSize {
        let timeIntervalSize = textSize(
            attributedString: task.timeIntreval,
            constraintWidth: prefferedWidth - textInsets.timeIntervalInsets.horizontal - textInsets.titleInsets.horizontal
        )
        let titleSize = textSize(
            attributedString: task.title,
            constraintWidth: prefferedWidth - textInsets.titleInsets.horizontal - textInsets.timeIntervalInsets.horizontal - timeIntervalSize.width
        )
        let descriptionSize = textSize(
            attributedString: task.description,
            constraintWidth: prefferedWidth - textInsets.descriptionInsets.horizontal
        )

        let titleHeight = textInsets.titleInsets.vertical + titleSize.height
        let timeIntervalHeight = textInsets.timeIntervalInsets.vertical + timeIntervalSize.height
        let descriptionHeight = descriptionSize.height + textInsets.descriptionInsets.vertical
        let height = max(titleHeight, timeIntervalHeight) + descriptionHeight
        let selectedHeight = height + textInsets.doneButtonInsets.vertical + 56

        return CGSize(
            width: prefferedWidth,
            height: ceil(task.isSelected ? selectedHeight : height)
        )
    }

    // MARK: - Private functions

    private func textSize(
        attributedString: NSAttributedString?,
        constraintWidth: CGFloat
    ) -> CGSize {
        guard let attributedText = attributedString else {
            return .zero
        }

        let constraintBox = CGSize(
            width: constraintWidth,
            height: .greatestFiniteMagnitude
        )
        let rect = attributedText.boundingRect(
            with: constraintBox,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        ).integral

        return rect.size
    }
}
