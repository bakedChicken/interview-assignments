//
//  AuthViewController.swift
//  feed-ios-application
//
//  Created by Artur Luppov on 11/9/18.
//  Copyright © 2018 Artur Luppov. All rights reserved.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    private struct StringResources {
        static let appId = "6746164"
    }

    private let scope = [String]()

    private var error: String? {
        didSet {
            errorLabel.text = error
            errorLabel.sizeToFit()
        }
    }

    private let errorLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.red
        view.sizeToFit()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSdk()

        VKSdk.wakeUpSession(scope) { [unowned self] state, _ in
            if state == .authorized {
                if let accessToken = VKSdk.accessToken()?.accessToken {
                    self.loginSuccess(token: accessToken)
                }
            }
        }
    }

    @objc func authButtonClicked(sender _: Any?) {
        VKSdk.wakeUpSession(scope) { [unowned self] state, error in
            if error != nil {
                self.error = error?.localizedDescription
            } else if state != .authorized {
                VKSdk.authorize(self.scope)
            } else {
                if let accessToken = VKSdk.accessToken()?.accessToken {
                    self.loginSuccess(token: accessToken)
                }
            }
        }
    }

    func loginSuccess(token _: String) {
        let navigationController = UINavigationController(rootViewController: FeedViewController())
        present(navigationController, animated: true, completion: nil)
    }
}

extension AuthViewController {
    func setupSdk() {
        let sdk = VKSdk.initialize(withAppId: StringResources.appId)
        sdk?.register(self)
    }

    func setupView() {
        view.backgroundColor = UIColor.white

        let button = UIButton()
        button.setTitle("Вход через ВК", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(authButtonClicked(sender:)), for: .touchUpInside)
        button.sizeToFit()
        button.center = view.center
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.bounds = button.frame.insetBy(dx: -10, dy: 0)
        view.addSubview(button)

        errorLabel.center = CGPoint(x: button.center.x, y: button.frame.maxY + 8)
        view.addSubview(errorLabel)
    }
}

extension AuthViewController: VKSdkDelegate {
    func vkSdkUserAuthorizationFailed() {
        error = "Произошла ошибка при авторизации"
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        loginSuccess(token: result.token.accessToken)
    }
}
