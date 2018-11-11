//
//  NewsTextLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsTextViewLayout {

    private(set) var textViewFrame: CGRect = .zero
    private(set) var showMoreLabelFrame: CGRect = .zero

    private(set) var size: CGSize = .zero

    mutating func calculateLayoutFitting(_ size: CGSize, for viewModel: NewsTextView.ViewModel) {
        let textContainer: NSTextContainer = {
            let container = NSTextContainer(size: size)
            container.lineFragmentPadding = 0
            return container
        }()

        let textStorage = NSTextStorage(attributedString: viewModel.text)

        let layoutManager: NSLayoutManager = {
            let layoutManager = NSLayoutManager()
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            return layoutManager
        }()

        let shouldShowMoreLabel = layoutManager.numberOfLines() > 8 && viewModel.state == .short
        if shouldShowMoreLabel {
            textContainer.maximumNumberOfLines = 6
            layoutManager.textContainerChangedGeometry(textContainer)
        }

        let textSize = CGSize(
            width: size.width,
            height: ceil(layoutManager.usedRect(for: textContainer).size.height)
        )

        self.textViewFrame = CGRect(origin: .zero, size: textSize)

        self.showMoreLabelFrame = CGRect(
            x: 0,
            y: self.textViewFrame.maxY,
            width: size.width,
            height: shouldShowMoreLabel ? 17 : 0
        )

        self.size = CGSize(
            width: size.width,
            height: self.textViewFrame.height + self.showMoreLabelFrame.height
        )
    }
}

extension NSLayoutManager {
    fileprivate func numberOfLines() -> Int {
        let numberOfGlyphs = self.numberOfGlyphs
        var numberOfLines = 0
        var index = 0
        var lineRange: NSRange = NSRange()

        while (index < numberOfGlyphs) {
            self.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange);
            numberOfLines = numberOfLines + 1
        }

        return numberOfLines
    }
}
