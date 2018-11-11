//
// Created by Artur Luppov on 11/9/18.
// Copyright (c) 2018 Artur Luppov. All rights reserved.
//

import UIKit

struct Post {
    let avatar: UIImage
    let name: String
    let date: Date
    let text: String
    let attachments: [UIImage]
    let likes: Int
    let comments: Int
    let shares: Int
    let views: Int
}

class FeedTableViewController: UITableViewController {
    var posts: [Post]! {
        didSet {
            tableView.reloadData()
        }
    }

    private struct StringResources {
        static let cellIdentifier = "feedCellIdentifier"
        static let headerIdentifier = "headerIdentifier"
        static let footerIdentifier = "footerIdentifier"
    }

    private struct ColorResources {
        static let backgroundColor = UIColor(red: 247 / 255, green: 249 / 255, blue: 250 / 255, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
}

extension FeedTableViewController {
    func setupView() {
        tableView.backgroundColor = ColorResources.backgroundColor
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
    }

    func setupTableView() {
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: StringResources.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FeedTableViewController {
    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next line_length force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: StringResources.cellIdentifier, for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]

        cell.delegate = self
        cell.avatarImageView.image = post.avatar
        cell.nameLabel.text = post.name
        cell.dateLabel.text = String(describing: post.date)
        cell.postLabel.text = post.text
        cell.images = post.attachments
        cell.likesCountLabel.text = String(describing: post.likes)
        cell.commentsCountLabel.text = String(describing: post.comments)
        cell.sharesCountLabel.text = String(describing: post.shares)
        cell.viewsCountLabel.text = String(describing: post.views)

        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedTableViewController: FeedTableViewCellShowMoreButtonDelegate {
    func onButtonPressed() {
        tableView.reloadData()
    }
}
