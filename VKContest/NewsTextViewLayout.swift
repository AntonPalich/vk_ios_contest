//
//  NewsTextLayout.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

struct NewsTextViewLayout {
    private(set) var size: CGSize = .zero

    mutating func calculateLayoutFitting(_ size: CGSize, forText text: String) {
        let textContainer: NSTextContainer = {
            let container = NSTextContainer(size: size)
            container.lineFragmentPadding = 0
            return container
        }()

        // FIXME: Pass attributed string for layout calculation
        let textStorage = NSTextStorage(
            string: text,
            attributes: [
                .font: UIFont.newsTextFont,
                .paragraphStyle: {
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    return paragraphStyle
                }()
            ])

        let layoutManager: NSLayoutManager = {
            let layoutManager = NSLayoutManager()
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            return layoutManager
        }()

        self.size = CGSize(
            width: size.width,
            height: ceil(layoutManager.usedRect(for: textContainer).size.height)
        )
    }
}
