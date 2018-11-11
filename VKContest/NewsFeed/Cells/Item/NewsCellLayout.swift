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
    private(set) var imageViewFrame: CGRect = .zero
    private(set) var barViewFrame: CGRect = .zero
    private(set) var size: CGSize = .zero

    private let backgroundImageViewInsets = UIEdgeInsets(top: 0, left: -10, bottom: -10, right: -10)
    private let headerInsets = UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20)
    private let textInsets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    private let barInsets = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 20)

    mutating func calculateLayoutFitting(_ size: CGSize, for viewModel: NewsCell.ViewModel) {
        let headerSize = size.inset(by: self.headerInsets)
        self.headerViewLayout.calculateLayoutFitting(headerSize)

        let barSize = size.inset(by: self.barInsets)
        self.barViewLayout.calculateLayoutFitting(barSize)

        let textSize = size.inset(by: self.textInsets)
        self.textViewLayout.calculateLayoutFitting(textSize, for: viewModel.textViewModel)

        self.headerViewFrame = CGRect(
            origin: CGPoint(
                x: self.headerInsets.left,
                y: self.headerInsets.top
            ),
            size: self.headerViewLayout.size
        )

        // FIXME: Поправить кейс когда нет текста
        self.textViewFrame = CGRect(
            origin: CGPoint(
                x: self.textInsets.left,
                y: self.headerViewFrame.maxY + self.textInsets.top
            ),
            size: self.textViewLayout.size
        )

        if let photoSize = viewModel.singlePhotoViewModel?.photo {
            let photoWidth = size.width - 16
            let aspectRatio = CGFloat(photoSize.width) / CGFloat(photoSize.height)
            let photoHeight = ceil(photoWidth / aspectRatio)
            self.imageViewFrame = CGRect(
                x: 8.0,
                y: self.textViewFrame.maxY + 10,
                width: photoWidth,
                height: photoHeight
            )
        } else {
            self.imageViewFrame = CGRect(
                x: 8.0,
                y: self.textViewFrame.maxY,
                width: 0,
                height: 0
            )
        }

        self.barViewFrame = CGRect(
            origin: CGPoint(
                x: self.barInsets.left,
                y: self.imageViewFrame.maxY
            ),
            size: self.barViewLayout.size
        )

        let height = (
            self.headerInsets.top
                + self.headerViewLayout.size.height
                + self.textInsets.top
                + self.textViewLayout.size.height
                + self.imageViewFrame.height + (self.imageViewFrame.height > 0 ? 10 : 0)
                + self.barViewLayout.size.height
                + self.barInsets.bottom
        )
        self.size = CGSize(width: size.width, height: height)

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
