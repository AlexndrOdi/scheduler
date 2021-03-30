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

    private let navigationBar = DashboardNavigationBar()
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
        view.backgroundColor = .white
        navigationBar.attributedTitle = NSAttributedString(
            string: "Today",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 28),
                .foregroundColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            ]
        )
        navigationBar.attributedSubtitle = NSAttributedString(
            string: "March 30, 2021",
            attributes: [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            ]
        )
        view.addSubview(navigationBar)
        view.addSubview(tasksWidget)
        navigationBar.scrollView = tasksWidget.scrollView
        viewModel.fetch()
        tasksWidget.reload(tasks: tasks)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBar.frame = CGRect(
            x: 20.0,
            y: .zero,
            width: view.bounds.width - 40.0,
            height: 200
        )
        tasksWidget.frame = CGRect(
            x: .zero,
            y: navigationBar.frame.maxY,
            width: view.bounds.width,
            height: view.bounds.height - navigationBar.frame.maxY
        )
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
