//
//  NewsCell.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    private let headerView = NewsHeaderView()
    private let barView = NewsBarView()
    private let textView: NewsTextView = {
        let textView = NewsTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = .all
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.bouncesZoom = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isExclusiveTouch = true
        textView.textContainer.lineFragmentPadding = 0
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textContainerInset = .zero
        return textView
    }()
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.backgroundImageView)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.barView)
        self.contentView.addSubview(self.textView)
        self.contentView.backgroundColor = .lightGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    struct ViewModel {
        let headerViewModel: NewsHeaderView.ViewModel
        let barViewModel: NewsBarView.ViewModel
        let text: String
    }

    var viewModel: ViewModel? {
        didSet {
            self.headerView.viewModel = self.viewModel?.headerViewModel
            self.barView.viewModel = self.viewModel?.barViewModel
            self.textView.text = self.viewModel?.text
        }
    }

    // MARK: Layout

    var layout = NewsCellLayout() {
        didSet {
            self.headerView.layout = self.layout.headerViewLayout
            self.barView.layout = self.layout.barViewLayout
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundImageView.frame = self.layout.backgroundImageViewFrame
        self.headerView.frame = self.layout.headerViewFrame
        self.textView.frame = self.layout.textViewFrame
        self.barView.frame = self.layout.barViewFrame
    }
}

private final class NewsTextView: UITextView {

    override var canBecomeFirstResponder: Bool {
        return false
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    override var selectedRange: NSRange {
        get {
            return NSRange(location: 0, length: 0)
        }
        set {
            // Part of the heaviest stack trace when scrolling (when updating text)
        }
    }

    override var contentOffset: CGPoint {
        get {
            return .zero
        }
        set {
            // Part of the heaviest stack trace when scrolling (when bounds are set)
        }
    }
}
