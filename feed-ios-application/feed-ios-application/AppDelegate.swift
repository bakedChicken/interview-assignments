//
//  AppDelegate.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/9/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // swiftlint:disable:next line_length
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        if let token = UserDefaults.standard.string(forKey: "access_token") {
            let service = VkService(token: token)
            let feedViewController = FeedViewController()
            feedViewController.service = service
            window?.rootViewController = UINavigationController(rootViewController: feedViewController)
        } else {
            window?.rootViewController = AuthViewController()
        }

        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}

    func application(_: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return VKSdk.processOpen(
            url,
            fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        )
    }
}
