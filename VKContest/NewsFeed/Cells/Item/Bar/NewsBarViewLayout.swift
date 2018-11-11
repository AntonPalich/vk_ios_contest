//
//  NewsBarViewLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsBarViewLayout {

    private(set) var likesButtonFrame: CGRect = .zero
    private(set) var commentsButtonFrame: CGRect = .zero
    private(set) var sharesButtonFrame: CGRect = .zero
    private(set) var viewsButtonFrame: CGRect = .zero
    private(set) var size: CGSize = .zero

    mutating func calculateLayoutFitting(_ size: CGSize) {
        let buttonSize = NewsBarViewLayout.buttonSize
        self.size = CGSize(width: size.width, height: buttonSize.height)

        self.likesButtonFrame = CGRect(origin: .zero, size: buttonSize)

        let commentsButtonOrigin = CGPoint(x: self.likesButtonFrame.maxX, y: 0)
        self.commentsButtonFrame = CGRect(origin: commentsButtonOrigin, size: buttonSize)

        let sharesButtonOrigin = CGPoint(x: self.commentsButtonFrame.maxX, y: 0)
        self.sharesButtonFrame = CGRect(origin: sharesButtonOrigin, size: buttonSize)

        let viewsButtonFrame = CGPoint(x: size.width - buttonSize.width, y: 0)
        self.viewsButtonFrame = CGRect(origin: viewsButtonFrame, size: buttonSize)
    }

    private static let buttonSize: CGSize = CGSize(width: 84, height: 44)
}
