//
//  FeedViewController.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/9/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableViewController()
    }
}

extension FeedViewController {
    func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    func setupTableViewController() {
        let tableViewController = FeedTableViewController()
        tableViewController.posts = [
            // swiftlint:disable:next all
            Post(avatar: UIImage(), name: "Андрей Рогозин", date: Date(), text: "2018-11-10 22:53:02.140761+0500 feed-ios-application[3146:1166977] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Application tried to present modally an active controller <feed_ios_application.AuthViewController: 0x10da08430>.djnskdnfjkdndnskcndskncksncdjs", attachments: [UIImage(named: "pizda")!], likes: 10, comments: 12, shares: 10, views: 26000),
            // swiftlint:disable:next all
            Post(avatar: UIImage(), name: "Андрей Рогозин", date: Date(), text: "2018-11-10 22:53:02.140761+0500 feed-ios-application[3146:1166977] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Application tried to present modally an active controller <feed_ios_application.AuthViewController: 0x10da08430>.djnskdnfjkdndnskcndskncksncdjs", attachments: [UIImage(named: "pizda")!, UIImage(named: "pizda")!], likes: 10, comments: 12, shares: 10, views: 26000),
        ]
        if #available(iOS 11.0, *) {
            tableViewController.view.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            tableViewController.view.frame = view.bounds
        }
        view.addSubview(tableViewController.view)
        addChild(tableViewController)
    }
}

extension FeedViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) {}
}
