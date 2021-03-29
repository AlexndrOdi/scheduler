//
//  TaskWidgetListAdapter.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

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
            TaskWidgetViewCell.self,
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
        ) as! TaskWidgetViewCell
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

// MARK: - TaskWidgetViewCellDelegate

extension TaskWidgetListAdapter: TaskWidgetViewCellDelegate {
    func widgetCellDidTapDoneButton(_ cell: TaskWidgetViewCell) {
        guard
            let indexPath = collectionView.indexPath(for: cell),
            let task = tasks[at: indexPath.item]
        else { return }
        task.isCompleted.toggle()
        collectionView.reloadItems(at: [indexPath])
        delegate?.adapter(self, didComplete: task, at: indexPath)
    }
}
