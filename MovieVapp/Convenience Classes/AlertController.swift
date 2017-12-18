//
//  AlertController.swift
//  MovieVapp
//
//  Created by Haiyan Ma on 18/12/2017.
//  Copyright © 2017 Haiyan Ma. All rights reserved.
//

import UIKit

protocol AlertControllable {
    var sortCompletion: ((SortType) -> ())? { get set }
    func presentSortOptions(on viewController: UIViewController, sortCompletion: ((SortType) -> ())?)
}

class AlertController: AlertControllable {

    var sortCompletion: ((SortType) -> ())?
    static let shared = AlertController()

    func presentSortOptions(on viewController: UIViewController, sortCompletion: ((SortType) -> ())?) {
        self.sortCompletion = sortCompletion

        let alert = UIAlertController(
            title: "Sort Movies by",
            message: nil,
            preferredStyle: .actionSheet
        )

        alert.addAction(alertActionWith(name: "Name",
                                        handler: { _ in
                                            self.sortCompletion?(SortType.name)}))

        alert.addAction(alertActionWith(name: "Rating",
                                        handler: { _ in
                                            self.sortCompletion?(SortType.rating)}))

        alert.addAction(alertActionWith(name: "Cancel",
                                        style: .cancel,
                                        handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

    private func alertActionWith(name: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: name, style: style, handler: handler)
    }
}
