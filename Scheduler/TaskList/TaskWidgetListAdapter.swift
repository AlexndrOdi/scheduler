//
//  TaskWidgetListAdapter.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

protocol ITaskWidgetListAdapter: AnyObject {

    // MARK: - Functions

    func task(for indexPath: IndexPath) -> ITask?
    func update(tasks: [ITask])
}

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

final class TaskWidgetListAdapter: NSObject, ITaskWidgetListAdapter {

    var reuse = "Widget"

    // MARK: - Properties

    weak var delegate: TaskWidgetListAdapterDelegate?

    // MARK: - Private properties

    private var tasks: [ITask] = []
    private unowned let collectionView: UICollectionView

    // MARK: - Initialization

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.register(
            TaskWidget.self,
            forCellWithReuseIdentifier: reuse
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    // MARK: - Functions

    func task(for indexPath: IndexPath) -> ITask? {
        tasks[at: indexPath.item]
    }

    func update(tasks: [ITask]) {
        self.tasks = tasks
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension TaskWidgetListAdapter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tasks.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let task = tasks[at: indexPath.item] else {
            return .init()
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuse,
            for: indexPath
        ) as! TaskWidget
        cell.configure(task: task)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TaskWidgetListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let task = tasks[at: indexPath.item] else {
            return
        }
        selectTask(at: indexPath)
        delegate?.adapter(self, didSelect: task, at: indexPath)
    }

    private func selectTask(at indexPath: IndexPath) {
        guard let task = tasks[at: indexPath.item] else {
            return
        }

        task.isSelected.toggle()
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - TaskWidgetDelegate

extension TaskWidgetListAdapter: TaskWidgetDelegate {
    func taskWidgetDidTapDoneButton(_ widget: TaskWidget) {
        guard
            let indexPath = collectionView.indexPath(for: widget),
            let task = tasks[at: indexPath.item]
        else { return }
        delegate?.adapter(self, didComplete: task, at: indexPath)
    }
}
