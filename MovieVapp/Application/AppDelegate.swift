//
//  AppDelegate.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 01/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        styleAppBar(application)
        navigateToRootVC()
        return true
    }

    private func navigateToRootVC() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let container = ListDependencyContainer()
        window?.rootViewController = UINavigationController(rootViewController: container.makeMovieListViewController())
    }
}

extension AppDelegate: AppBarStylable {}
