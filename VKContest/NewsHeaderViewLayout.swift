//
//  NewsHeaderViewLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsHeaderViewLayout {

    private(set) var avatarImageViewFrame: CGRect = .zero
    private(set) var nameLabelFrame: CGRect = .zero
    private(set) var dateLabelFrame: CGRect = .zero
    private(set) var size: CGSize = .zero

    mutating func calculateLayoutFitting(_ size: CGSize) {
        let height = NewsHeaderViewLayout.height
        self.size = CGSize(width: size.width, height: height)

        self.avatarImageViewFrame = CGRect(origin: .zero, size: CGSize(width: height, height: height))

        let textOriginX = self.avatarImageViewFrame.maxX + 10
        self.nameLabelFrame = CGRect(
            x: textOriginX,
            y: 2,
            width: size.width - textOriginX,
            height: 17
        )
        self.dateLabelFrame = CGRect(
            x: textOriginX,
            y: self.nameLabelFrame.maxY + 1,
            width: size.width - textOriginX,
            height: 15
        )
    }

    private static let height: CGFloat = 36
}
