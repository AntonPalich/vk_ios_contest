//
//  AuthorizationService.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import VKSdkFramework

protocol AuthorizationServiceDelegate: AnyObject {
    func authorizationService(_ service: AuthorizationService, didAuthorizeWithToken token: VKAccessToken)
    func authorizationServiceDidFailToAuthorize(_ service: AuthorizationService)
    func authorizationService(_ service: AuthorizationService, shouldPresentViewController viewController: UIViewController)
}

final class AuthorizationService: NSObject {

    weak var delegate: AuthorizationServiceDelegate?

    private let sdk: VKSdk

    init(appId: String) {
        self.sdk = VKSdk.initialize(withAppId: appId)
        super.init()
        self.sdk.register(self)
        self.sdk.uiDelegate = self
    }

    func authorize() {
        VKSdk.wakeUpSession([]) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize([])
            case .authorized:
                self.delegate?.authorizationService(self, didAuthorizeWithToken: VKSdk.accessToken())
            case .error, .unknown:
                self.delegate?.authorizationServiceDidFailToAuthorize(self)
            case .pending, .external, .safariInApp, .webview:
                break
            }
        }
    }
}

extension AuthorizationService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            self.delegate?.authorizationService(self, didAuthorizeWithToken: result.token)
        } else {
            self.delegate?.authorizationServiceDidFailToAuthorize(self)
        }
    }

    func vkSdkUserAuthorizationFailed() {
        self.delegate?.authorizationServiceDidFailToAuthorize(self)
    }
}

extension AuthorizationService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.delegate?.authorizationService(self, shouldPresentViewController: controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        assertionFailure("Unhandled situation")
    }
}
