//
//  FeedViewController.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/9/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    struct ColorResources {
        static let backgroundTopColor = UIColor(red: 235 / 255, green: 237 / 255, blue: 240 / 255, alpha: 1)
        static let backgroundBottomColor = UIColor(red: 247 / 255, green: 249 / 255, blue: 250 / 255, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setupSearchController()
    }
}

extension FeedViewController {
    func setupView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [ColorResources.backgroundTopColor.cgColor, ColorResources.backgroundBottomColor.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // TODO: too hacky; think about it
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.isTranslucent = true
    }

    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    }
}

extension FeedViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) {}
}
