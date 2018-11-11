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

    private let height: CGFloat = 36
    private let nameLabelHeight: CGFloat = 17
    private let nameLabelInsets = UIEdgeInsets(top: 2, left: 9, bottom: 0, right: 0)
    private let dateLabelHeight: CGFloat = 15
    private let dateLabelInsets = UIEdgeInsets(top: 1, left: 9, bottom: 0, right: 0)

    mutating func calculateLayoutFitting(_ size: CGSize) {
        self.size = CGSize(width: size.width, height: self.height)

        self.avatarImageViewFrame = CGRect(origin: .zero, size: CGSize(width: self.height, height: self.height))

        let nameLabelOriginX = self.avatarImageViewFrame.maxX + self.nameLabelInsets.left
        self.nameLabelFrame = CGRect(
            x: nameLabelOriginX,
            y: self.nameLabelInsets.top,
            width: size.width - nameLabelOriginX,
            height: self.nameLabelHeight
        )

        let dateLabelOriginX = nameLabelOriginX
        self.dateLabelFrame = CGRect(
            x: dateLabelOriginX,
            y: self.nameLabelFrame.maxY + self.dateLabelInsets.top,
            width: size.width - dateLabelOriginX,
            height: self.dateLabelHeight
        )
    }
}
