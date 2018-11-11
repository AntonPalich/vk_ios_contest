//
//  Router.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import VKSdkFramework
import UIKit

enum Route {
    case authorization(appId: String)
    case newsFeed(token: VKAccessToken)
}

class Router {
    private weak var rootViewController: UIViewController?

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func route(to route: Route) {
        switch route {
        case .authorization(let appId):
            let viewController = AuthorizationViewController(
                authorizationService: AuthorizationService(appId: appId),
                router: self
            )
            self.present(viewController: viewController)
        case .newsFeed(let token):
            let viewController = NewsFeedContainerViewController(
                networkService: NetworkService(token: token)
            )
            self.present(viewController: UINavigationController(rootViewController: viewController))
        }
    }

    private weak var presentedViewController: UIViewController?

    private func present(viewController: UIViewController) {
        guard let rootViewController = self.rootViewController else { return }
        self.presentedViewController?.vk_removeFromParent()
        rootViewController.vk_addSubview(from: viewController)
        viewController.view.frame = rootViewController.view.bounds
    }
}
