//
//  ITaskWidgetListAdapter.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 29.03.2021.
//

import Foundation

protocol ITaskWidgetListAdapter: AnyObject {

    // MARK: - Functions

    func task(for indexPath: IndexPath) -> ITask?
    func update(tasks: [ITask])
}
