//
//  NewsTextView.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsTextView: UIView {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textView)
        self.addSubview(self.showMoreLabel)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onShowMoreTapped))
        self.showMoreLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    struct ViewModel {
        typealias Action = () -> Void
        enum State {
            case short, full
        }
        var state: State
        let text: NSAttributedString
        let onShowMoreTapped: Action?
    }

    var viewModel: ViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.textView.attributedText = viewModel.text
            } else {
                self.textView.attributedText = nil
            }
        }
    }

    // MARK: Layout

    var layout = NewsTextViewLayout() {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textView.frame = self.layout.textViewFrame
        self.showMoreLabel.frame = self.layout.showMoreLabelFrame
    }

    // MARK: Text

    private let textView: PerformantTextView = {
        let textView = PerformantTextView()
        textView.isEditable = false
        textView.isSelectable = false // true?
        textView.dataDetectorTypes = .all
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.bouncesZoom = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isExclusiveTouch = true
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }()
    
    // MARK: Show more

    private let showMoreLabel: UILabel = {
        let label = UILabel()
        label.font = .newsTextFont
        label.textColor = .newsShowMoreLabelColor
        label.text = "Показать полностью..."
        label.isUserInteractionEnabled = true
        return label
    }()

    @objc
    private func onShowMoreTapped() {
        self.viewModel?.onShowMoreTapped?()
    }
}

private final class PerformantTextView: UITextView {

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
