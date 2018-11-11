//
//  Post.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/11/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

struct NewsfeedObjectResponse: Codable {
    let response: NewsfeedResponse

    private enum CodingKeys: String, CodingKey {
        case response
    }
}

struct NewsfeedResponse: Codable {
    let items: [NewsfeedItem]
    let profiles: [UserInfo]
    let groups: [NewsfeedGroup]
    let nextFrom: String

    private enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

struct NewsfeedItem: Codable {
    let type: String
    let sourceId: Int
    let date: Int
    let text: String?
    let comments: Counts?
    let likes: Counts?
    let reposts: Counts?
    let attachments: [Attachment]?

    private enum CodingKeys: String, CodingKey {
        case type
        case sourceId = "source_id"
        case date
        case text
        case comments
        case likes
        case reposts
        case attachments
    }
}

struct Attachment: Codable {
    let type: String
    let photo: PhotoAttachment?

    private enum CodingKeys: String, CodingKey {
        case type
        case photo
    }
}

struct PhotoAttachment: Codable {
    let photoUrl: String

    private enum CodingKeys: String, CodingKey {
        case photoUrl = "photo_604"
    }
}

struct Counts: Codable {
    let count: Int

    private enum CodingKeys: String, CodingKey {
        case count
    }
}

struct NewsfeedGroup: Codable {
    let id: Int
    let name: String
    let photoUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoUrl = "photo_50"
    }
}

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
