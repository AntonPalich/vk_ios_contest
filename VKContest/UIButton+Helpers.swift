//
//  UIButton+Helpers.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

extension UIButton {
    func vk_set(imageFromTitleOffset offset: CGFloat) {
        let inset = offset / 2
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -inset, bottom: 0, right: inset)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: -inset)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}
