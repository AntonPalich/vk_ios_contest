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

        let textStorage = NSTextStorage(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14)])

        let layoutManager: NSLayoutManager = {
            let layoutManager = NSLayoutManager()
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            return layoutManager
        }()

        self.size = CGSize(width: size.width, height: layoutManager.usedRect(for: textContainer).size.height)
    }
}
