//
//  TaskWidgetListAdapterDelegate.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 29.03.2021.
//

import Foundation

protocol TaskWidgetListAdapterDelegate: AnyObject {

    // MARK: - Functions

    func adapter(
        _ adapter: ITaskWidgetListAdapter,
        didComplete task: ITask,
        at indexPath: IndexPath
    )

    func adapter(
        _ adapter: ITaskWidgetListAdapter,
        didSelect task: ITask,
        at indexPath: IndexPath
    )
}
