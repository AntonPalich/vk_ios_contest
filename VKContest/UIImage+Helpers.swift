//
//  UIImage+Helpers.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else {
            self.init()
            return
        }

        context.setFillColor(color.cgColor)
        context.fill(rect)

        guard let cgImage = context.makeImage() else {
            self.init()
            return
        }

        self.init(cgImage: cgImage)
    }
}
