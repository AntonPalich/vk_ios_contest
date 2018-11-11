//
//  NewsMultiplePhotoViewLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsMultiplePhotoViewLayout {
    private(set) var size: CGSize = .zero

    private(set) var collectionViewFrame: CGRect = .zero
    private(set) var pageIndicatorFrame: CGRect = .zero
    private(set) var separatorFrame: CGRect = .zero

    mutating func calculateLayoutFitting(_ size: CGSize) {
        self.collectionViewFrame = CGRect(
            origin: .zero,
            size: CGSize(
                width: size.width,
                height: 320
            )
        )

        self.pageIndicatorFrame = CGRect(
            x: 0,
            y: self.collectionViewFrame.maxY,
            width: size.width,
            height: 39
        )

        self.separatorFrame = CGRect(
            x: 12,
            y: self.pageIndicatorFrame.maxY,
            width: size.width - 24,
            height: 1
        )

        self.size = CGSize(width: size.width, height: self.separatorFrame.maxY)
    }
}
