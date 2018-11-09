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

    private var layout = NewsBarViewLayout()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout.calculateLayoutFitting(self.bounds.size)
        self.likesButton.frame = self.layout.likesButtonFrame
        self.commentsButton.frame = self.layout.commentsButtonFrame
        self.sharesButton.frame = self.layout.sharesButtonFrame
        self.viewsButton.frame = self.layout.viewsButtonFrame
    }

    // MARK: Likes

    private let likesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onLikesTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "Like_outline_24"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
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
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onCommentsTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "Comment_outline_24"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
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
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onSharesTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "Share_outline_24"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
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
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private func set(views: String) {
        self.viewsButton.setTitle(views, for: .normal)
    }
}
