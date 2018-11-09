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

    private let backgroundImageViewInsets = UIEdgeInsets(top: 0, left: -10, bottom: -10, right: -10)
    private let headerInsets = UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20)
    private let textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    private let barInsets = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)

    mutating func calculateLayoutFitting(_ size: CGSize, forText text: String) {
        let headerSize = size.inset(by: self.headerInsets)
        self.headerViewLayout.calculateLayoutFitting(headerSize)

        let barSize = size.inset(by: self.barInsets)
        self.barViewLayout.calculateLayoutFitting(barSize)

        let textSize = size.inset(by: self.textInsets)
        self.textViewLayout.calculateLayoutFitting(textSize, forText: text)

        let height = (
            self.headerInsets.top
            + self.headerViewLayout.size.height
            + self.textViewLayout.size.height
            + self.barViewLayout.size.height
            + self.barInsets.bottom
        )
        self.size = CGSize(width: size.width, height: height)

        self.headerViewFrame = CGRect(
            origin: CGPoint(
                x: self.headerInsets.left,
                y: self.headerInsets.top
            ),
            size: self.headerViewLayout.size
        )

        self.textViewFrame = CGRect(
            origin: CGPoint(
                x: self.textInsets.left,
                y: self.headerViewFrame.maxY
            ),
            size: self.textViewLayout.size
        )

        self.barViewFrame = CGRect(
            origin: CGPoint(
                x: self.barInsets.left,
                y: self.textViewFrame.maxY
            ),
            size: self.barViewLayout.size
        )

        let backgroundImageViewSize = self.size.inset(by: self.backgroundImageViewInsets)
        self.backgroundImageViewFrame = CGRect(
            origin: CGPoint(
                x: self.backgroundImageViewInsets.left,
                y: self.backgroundImageViewInsets.top
            ),
            size: backgroundImageViewSize
        )
    }
}
