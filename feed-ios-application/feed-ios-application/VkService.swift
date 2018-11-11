//
//  VkService.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/11/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum Method: String {
    case userInfo = "users.get"
    case feed = "newsfeed.getRecommended"
    case search = "newsfeed.search"
}

class VkService {
    private let token: String
    private let apiVersion = "5.21"

    init(token: String) {
        self.token = token
    }

    func fetchUserInformation(callback: @escaping (Result<UserInfoResponse>) -> Void) {
        var builder = URLComponents()
        builder.scheme = "https"
        builder.host = "api.vk.com"
        builder.path = "/method/\(Method.userInfo.rawValue)"
        builder.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: apiVersion),
            URLQueryItem(name: "fields", value: "photo_50"),
        ]

        URLSession.shared.dataTask(with: builder.url!) { data, _, error in
            if let error = error {
                callback(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(UserInfoResponse.self, from: data)
                    callback(.success(response))
                } catch let error {
                    callback(.failure(error))
                }
            }
        }.resume()
    }

    func fetchNewsfeed(callback: @escaping (Result<[Post]>) -> Void) {
        var builder = URLComponents()
        builder.scheme = "https"
        builder.host = "api.vk.com"
        builder.path = "/method/\(Method.feed.rawValue)"
        builder.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: apiVersion),
        ]

        URLSession.shared.dataTask(with: builder.url!) { [unowned self] data, _, error in
            if let error = error {
                callback(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(NewsfeedObjectResponse.self, from: data)
                    let posts = self.parseNewsfeed(with: response)
                    callback(.success(posts))
                } catch let error {
                    callback(.failure(error))
                }
            }
        }.resume()
    }

    private func parseNewsfeed(with response: NewsfeedObjectResponse) -> [Post] {
        let response = response.response
        let items = response.items.filter {
            $0.type == "post" && $0.likes != nil && $0.comments != nil && $0.reposts != nil
        }

        return items.map { item in
            func getName(by id: Int) -> String {
                if let user = response.profiles.first(where: { $0.id == id }) {
                    return "\(user.firstName) \(user.lastName)"
                } else if let group = response.groups.first(where: { $0.id == id }) {
                    return group.name
                }

                return "Gopa"
            }

            return Post(
                avatar: UIImage(),
                name: getName(by: item.sourceId),
                date: Date(timeIntervalSince1970: Double(item.date)),
                text: item.text ?? "",
                attachments: item.attachments?.filter { $0.type == "photo" && $0.photo != nil }.map { _ in UIImage() } ?? [],
                likes: item.likes!.count,
                comments: item.comments!.count,
                shares: item.reposts!.count,
                views: 0
            )
        }
    }
}
