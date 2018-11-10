//
//  UIViewController+Helpers.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

extension UIViewController {
    func vk_addSubview(from controller: UIViewController) {
        self.vk_addChild(childController: controller)
        self.view.addSubview(controller.view)
    }

    func vk_addChild(childController: UIViewController) {
        assert(childController.parent == nil, "Remove controller from other container first")
        // willMove(toParent:) automatically called within addChild()
        self.addChild(childController)
        childController.didMove(toParent: self)
    }

    func vk_removeFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        // didMove(toParent:) automatically called withing removeFromParent()
    }
}
