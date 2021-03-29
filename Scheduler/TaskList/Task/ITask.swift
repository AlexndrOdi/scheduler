//
//  ITask.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import Foundation

protocol ITask: AnyObject {

    // MARK: - Properties

    var title: NSAttributedString? { get }
    var description: NSAttributedString? { get }
    var timeIntreval: NSAttributedString? { get }
    var isSelected: Bool { get set }
    var isCompleted: Bool { get set }
}
