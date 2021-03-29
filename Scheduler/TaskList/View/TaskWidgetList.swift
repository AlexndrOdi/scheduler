//
//  TaskWidgetList.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

final class TaskWidgetList: UIView {

    // MARK: - Views

    private let collectionView: UICollectionView

    // MARK: - Properties

    // MARK: - Private properties

    private let adapter: ITaskWidgetListAdapter
    private let widgetCalculator: ITaskWidgetSizeCalculator

    // MARK: - Initialization

    init() {
        let flowLayout = TaskWidgetListFlowLayout()
        self.collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        let adapter = TaskWidgetListAdapter(
            collectionView: collectionView
        )
        self.adapter = adapter
        self.widgetCalculator = TaskWidgetSizeCalculator()
        super.init(frame: .zero)
        adapter.delegate = self
        flowLayout.delegate = self
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }

    // MARK: - Functions

    func reload(tasks: [ITask]) {
        adapter.update(tasks: tasks)
    }

    // MARK: - Private functions

    private func setup() {
        collectionView.backgroundColor = .white
        addSubview(collectionView)
    }
}

// MARK: - TaskWidgetListFlowLayoutDelegate

extension TaskWidgetList: TaskWidgetListFlowLayoutDelegate {
    func flowLayout(
        _ flowLayout: TaskWidgetListFlowLayout,
        sizeForWidgetAt indexPath: IndexPath,
        with textInsets: WidgetTextInsets,
        prefferedWidth: CGFloat
    ) -> CGSize {
        guard let task = adapter.task(for: indexPath) else {
            return .zero
        }
        return widgetCalculator.size(
            for: task,
            with: prefferedWidth,
            textInsets: textInsets
        )
    }
}

// MARK: - TaskWidgetListAdapterDelegate

extension TaskWidgetList: TaskWidgetListAdapterDelegate {
    func adapter(
        _ adapter: ITaskWidgetListAdapter,
        didComplete task: ITask,
        at indexPath: IndexPath
    ) {
        print(task)
    }

    func adapter(
        _ adapter: ITaskWidgetListAdapter,
        didSelect task: ITask,
        at indexPath: IndexPath
    ) {
        print(task)
    }
}
