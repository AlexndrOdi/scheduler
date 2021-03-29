//
//  ITaskWidgetListViewModel.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import Foundation

protocol ITasksService: AnyObject {
}

final class TasksService: ITasksService {
}

protocol ITaskWidgetListViewModel: AnyObject {

    // MARK: - Functions

    func fetch()
}

final class TaskWidgetListViewModel: ITaskWidgetListViewModel {

    // MARK: - Private properties

    private let service: ITasksService

    // MARK: - Initialization

    init(service: ITasksService) {
        self.service = service
    }

    // MARK: - Functions

    func fetch() {
    }
}
