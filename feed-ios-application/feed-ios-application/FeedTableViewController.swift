//
// Created by Artur Luppov on 11/9/18.
// Copyright (c) 2018 Artur Luppov. All rights reserved.
//

import UIKit

class Post {}

class FeedTableViewController: UITableViewController {
    var posts: [Post]!

    private struct StringResources {
        static let cellIdentifier = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: StringResources.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next all
        let cell = tableView.dequeueReusableCell(withIdentifier: StringResources.cellIdentifier, for: indexPath) as! FeedTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return posts.count
    }

    public override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100
    }
}
