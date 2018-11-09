//
//  NewsCellLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsCellLayout {
    private(set) var headerViewLayout = NewsHeaderViewLayout()
    private(set) var textViewLayout = NewsTextViewLayout()
    private(set) var barViewLayout = NewsBarViewLayout()

    private(set) var backgroundImageViewFrame: CGRect = .zero
    private(set) var headerViewFrame: CGRect = .zero
    private(set) var textViewFrame: CGRect = .zero
    private(set) var barViewFrame: CGRect = .zero
    private(set) var size: CGSize = .zero

    private let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    mutating func calculateLayoutFitting(_ size: CGSize, forText text: String) {
        let contentSize = CGSize(
            width: size.width - self.insets.left - self.insets.right,
            height: size.height
        )
        self.headerViewLayout.calculateLayoutFitting(contentSize)
        self.barViewLayout.calculateLayoutFitting(contentSize)
        self.textViewLayout.calculateLayoutFitting(contentSize, forText: text)

        let contentHeight = self.headerViewLayout.size.height + self.barViewLayout.size.height + self.textViewLayout.size.height
        self.size = CGSize(
            width: size.width,
            height: contentHeight + self.insets.top + self.insets.bottom
        )

        let contentOrigin = CGPoint(x: self.insets.left, y: self.insets.top)
        self.headerViewFrame = CGRect(origin: contentOrigin, size: self.headerViewLayout.size)
        self.textViewFrame = CGRect(origin: CGPoint(x: contentOrigin.x, y: self.headerViewFrame.maxY), size: self.textViewLayout.size)
        self.barViewFrame = CGRect(origin: CGPoint(x: contentOrigin.x, y: self.textViewFrame.maxY), size: self.barViewLayout.size)

        self.backgroundImageViewFrame = CGRect(
            x: contentOrigin.x,
            y: contentOrigin.y,
            width: contentSize.width,
            height: contentHeight
        )
    }
}
