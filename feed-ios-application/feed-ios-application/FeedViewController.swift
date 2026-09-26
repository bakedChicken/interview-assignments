//
//  FeedViewController.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/9/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    var service: VkService!

    let tableViewController = FeedTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableViewController()

        service.fetchUserInformation { result in
            switch result {
            case let .success(userInfo):
                print(userInfo)
            case let .failure(error):
                print(error)
            }
        }

        service.fetchNewsfeed { result in
            switch result {
            case let .success(newsfeedResponse):
                DispatchQueue.main.async {
                    self.tableViewController.posts = newsfeedResponse
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension FeedViewController {
    func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    func setupTableViewController() {
        tableViewController.posts = []
        if #available(iOS 11.0, *) {
            tableViewController.view.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            tableViewController.view.frame = view.bounds
        }
        view.addSubview(tableViewController.view)
        addChild(tableViewController)
    }
}
