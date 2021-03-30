//
//  AppDelegate.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 26.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DashboardViewController(viewModel: TaskWidgetListViewModel(service: TasksService()))
        window?.makeKeyAndVisible()
        return true
    }
}

