//
//  NewsBarView.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsBarView: UIView {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.likesButton)
        self.addSubview(self.sharesButton)
        self.addSubview(self.commentsButton)
        self.addSubview(self.viewsButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    struct ViewModel {
        typealias Action = () -> Void

        let likes: String
        let comments: String
        let shares: String
        let views: String

        let onLikesTapped: Action?
        let onCommentsTapped: Action?
        let onSharesTapped: Action?
    }

    var viewModel: ViewModel? {
        didSet {
            self.update()
        }
    }

    private func update() {
        if let viewModel = self.viewModel {
            self.set(likes: viewModel.likes)
            self.set(comments: viewModel.comments)
            self.set(shares: viewModel.shares)
            self.set(views: viewModel.views)
        } else {
            self.set(likes: "")
            self.set(comments: "")
            self.set(shares: "")
            self.set(views: "")
        }
    }

    // MARK: Layout

    var layout = NewsBarViewLayout() {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.likesButton.frame = self.layout.likesButtonFrame
        self.commentsButton.frame = self.layout.commentsButtonFrame
        self.sharesButton.frame = self.layout.sharesButtonFrame
        self.viewsButton.frame = self.layout.viewsButtonFrame
    }

    // MARK: Likes

    private let likesButton: UIButton = {
        return UIButton.makeBarButton(
            image: UIImage(named: "Like_outline_24"),
            target: self,
            selector:  #selector(onLikesTapped)
        )
    }()

    private func set(likes: String) {
        self.likesButton.setTitle(likes, for: .normal)
    }

    @objc
    private func onLikesTapped() {
        self.viewModel?.onLikesTapped?()
    }

    // MARK: Comments

    private let commentsButton: UIButton = {
        return UIButton.makeBarButton(
            image: UIImage(named: "Comment_outline_24"),
            target: self,
            selector: #selector(onCommentsTapped)
        )
    }()

    private func set(comments: String) {
        self.commentsButton.setTitle(comments, for: .normal)
    }

    @objc
    private func onCommentsTapped() {
        self.viewModel?.onCommentsTapped?()
    }

    // MARK: Shares

    private let sharesButton: UIButton = {
        return UIButton.makeBarButton(
            image: UIImage(named: "Share_outline_24"),
            target: self,
            selector: #selector(onSharesTapped)
        )
    }()

    private func set(shares: String) {
        self.sharesButton.setTitle(shares, for: .normal)
    }

    @objc
    private func onSharesTapped() {
        self.viewModel?.onSharesTapped?()
    }

    // MARK: Views

    private let viewsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "View_20"), for: .normal)
        button.titleLabel?.font = .newsBarButtonFont
        button.setTitleColor(.newsBarViewsButtonColor, for: .normal)
        button.tintColor = .newsBarViewsButtonColor
        button.vk_set(imageFromTitleOffset: 4)
        button.contentHorizontalAlignment = .right
        return button

    }()

    private func set(views: String) {
        self.viewsButton.setTitle(views, for: .normal)
    }
}

extension UIButton {
    static fileprivate func makeBarButton(image: UIImage?,
                                          target: Any?,
                                          selector: Selector?,
                                          font: UIFont = .newsBarButtonFont,
                                          color: UIColor = .newsBarButtonColor) -> UIButton {
        let button = NewsBarButton(type: .custom)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(color, for: .normal)
        button.tintColor = color
        if let selector = selector {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        return button
    }
}

// FIXME: Do alignment according to design
private class NewsBarButton: UIButton {
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = super.imageRect(forContentRect: contentRect)
        return CGRect(
            x: contentRect.midX - imageRect.width - 2,
            y: contentRect.midY - imageRect.height / 2,
            width: imageRect.width,
            height: imageRect.height
        )
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        return CGRect(
            x: contentRect.midX + 2,
            y: contentRect.midY - titleRect.height / 2,
            width: titleRect.width,
            height: titleRect.height
        )
    }
}
