//
//  AppDelegateProtocols.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 05/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

protocol AppBarStylable {
    func setNavBarStyle()
    func setStatusBarStyle(_ application: UIApplication)
}

extension AppBarStylable {
    func setNavBarStyle() {
        UINavigationBar.appearance().barTintColor = UIColor.themePurple()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    func setStatusBarStyle(_ application: UIApplication) {
        application.statusBarStyle = .lightContent
    }

    func styleAppBar(_ application: UIApplication) {
        setNavBarStyle()
        setStatusBarStyle(application)
    }
}
