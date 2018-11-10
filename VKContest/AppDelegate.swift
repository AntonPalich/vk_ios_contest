//
//  AppDelegate.swift
//  VKContest
//
//  Created by Anton Schukin on 08/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import VKSdkFramework
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = UIViewController()
        self.router = Router(rootViewController: rootViewController)
        self.router?.route(to: .authorization(appId: "6746069"))

        self.window = UIWindow()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[.sourceApplication] as? String
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
}
