//
//  UserInfo.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/11/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

struct UserInfoResponse: Codable {
    let response: [UserInfo]

    private enum CodingKeys: String, CodingKey {
        case response
    }
}

// swiftlint:disable:all identifier_name
struct UserInfo: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photoUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_50"
    }
}
