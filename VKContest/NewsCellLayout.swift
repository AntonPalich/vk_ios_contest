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

    private(set) var headerViewFrame: CGRect = .zero
    private(set) var textViewFrame: CGRect = .zero
    private(set) var barViewFrame: CGRect = .zero
    private(set) var size: CGSize = .zero

    mutating func calculateLayoutFitting(_ size: CGSize, forText text: String) {
        self.headerViewLayout.calculateLayoutFitting(size)
        self.barViewLayout.calculateLayoutFitting(size)
        self.textViewLayout.calculateLayoutFitting(size, forText: text)

        self.size = CGSize(
            width: size.width,
            height: self.headerViewLayout.size.height + self.barViewLayout.size.height + self.textViewLayout.size.height
        )
        self.headerViewFrame = CGRect(origin: .zero, size: self.headerViewLayout.size)
        self.textViewFrame = CGRect(origin: CGPoint(x: 0, y: self.headerViewFrame.maxY), size: self.textViewLayout.size)
        self.barViewFrame = CGRect(origin: CGPoint(x: 0, y: self.textViewFrame.maxY), size: self.barViewLayout.size)
    }
}
