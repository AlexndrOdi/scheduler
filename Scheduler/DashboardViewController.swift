//
//  DashboardViewController.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

final class DashboardViewController: UIViewController {

    // MARK: - Constants

    // MARK: - Views

    private let tasksWidget = TaskWidgetList()

    // MARK: - Properties

    // MARK: - Private properties

    private let viewModel: ITaskWidgetListViewModel

    // MARK: - Initialization

    init(viewModel: ITaskWidgetListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("DashboardViewController ::: init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tasksWidget)
        viewModel.fetch()
        tasksWidget.reload(tasks: tasks)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tasksWidget.frame = view.bounds
    }

    // MARK: - Functions

    // MARK: - Private functions


    private var tasks: [ITask] {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        return [
            Task(
                title: NSAttributedString(
                    string: "Meeting",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "Discuss team tasks for the day",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "11:00 AM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Tech meeting",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "Discuss tech team tasks and problems for the day",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "11:30 AM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Diner",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "Um-num-num",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "12:00 AM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Sleep",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "ZZZzzzZZZzzzZZZzzz",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "14:00 PM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Meeting",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "Discuss team tasks for the day again ...",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "15:00 PM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Meeting",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "And again ...",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "16:00 PM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            ),
            Task(
                title: NSAttributedString(
                    string: "Go home",
                    attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "...",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "17:00 PM",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                isCompleted: false
            )
        ]
    }

}
