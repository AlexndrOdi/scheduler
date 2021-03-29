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
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            ),
            Task(
                title: NSAttributedString(
                    string: "title title title title title title title title title title title title ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                description: NSAttributedString(
                    string: "description description description description description description description ",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                ),
                timeIntreval: NSAttributedString(
                    string: "time --- to time",
                    attributes: [.font: UIFont.systemFont(ofSize: 17),
                                 .paragraphStyle: style]
                )
            )
        ]
    }

}
