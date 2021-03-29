//
//  Task.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import Foundation

final class Task: ITask {

    // MARK: - Properties

    let title: NSAttributedString?
    let description: NSAttributedString?
    let timeIntreval: NSAttributedString?
    var isSelected: Bool

    // MARK: - Initialization

    init(
        title: NSAttributedString?,
        description: NSAttributedString?,
        timeIntreval: NSAttributedString?
    ) {
        self.title = title
        self.description = description
        self.timeIntreval = timeIntreval
        self.isSelected = false
    }

}
