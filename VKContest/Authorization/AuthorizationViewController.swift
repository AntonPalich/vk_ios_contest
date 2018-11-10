//
//  AuthorizationViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import VKSdkFramework
import UIKit

class AuthorizationViewController: UIViewController {

    private let authorizationService: AuthorizationService
    private let router: Router

    init(authorizationService: AuthorizationService, router: Router) {
        self.authorizationService = authorizationService
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.authorizationService.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.authorizationButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.authorizationButton.sizeToFit()
        self.authorizationButton.center = self.view.center
    }

    private var isFirstAuthorizationAttempt = true

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isFirstAuthorizationAttempt {
            self.authorize()
        }
    }

    @objc
    private func authorize() {
        self.authorizationService.authorize()
        self.isFirstAuthorizationAttempt = false
    }

    private let authorizationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Авторизоваться", for: .normal)
        button.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
}

extension AuthorizationViewController: AuthorizationServiceDelegate {
    func authorizationService(_ service: AuthorizationService, didAuthorizeWithToken token: VKAccessToken) {
        self.router.route(to: .newsFeed(token: token))
    }

    func authorizationServiceDidFailToAuthorize(_ service: AuthorizationService) {
        self.authorizationButton.isHidden = false
    }

    func authorizationService(_ service: AuthorizationService, shouldPresentViewController viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}
