//
//  ViewController.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 26.03.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
//        node.fillColor = #colorLiteral(red: 1, green: 0.582778573, blue: 0.09732390195, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = DashboardViewController(
            viewModel: TaskWidgetListViewModel(service: TasksService())
        )
        self.navigationController?.pushViewController(controller, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

}
