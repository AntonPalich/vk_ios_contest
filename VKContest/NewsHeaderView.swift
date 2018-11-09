//
//  NewsHeaderView.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsHeaderView: UIView {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.avatarImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dateLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    struct ViewModel {
        let avatarImage: UIImage?
        let name: String
        let date: String
    }

    var viewModel: ViewModel? {
        didSet {
            self.update()
        }
    }

    private func update() {
        if let viewModel = self.viewModel {
            self.set(avatarImage: viewModel.avatarImage)
            self.set(name: viewModel.name)
            self.set(date: viewModel.date)
        } else {
            self.set(avatarImage: nil)
            self.set(name: "")
            self.set(date: "")
        }
    }

    // MARK: Layout

    var layout = NewsHeaderViewLayout() {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.frame = self.layout.avatarImageViewFrame
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
        self.avatarImageView.layer.masksToBounds = true
        self.nameLabel.frame = self.layout.nameLabelFrame
        self.dateLabel.frame = self.layout.dateLabelFrame
    }

    // MARK: Avatar

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private func set(avatarImage: UIImage?) {
        self.avatarImageView.image = avatarImage
    }

    // MARK: Name

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .headerNameColor
        label.font = .headerNameFont
        return label
    }()

    private func set(name: String) {
        self.nameLabel.text = name
    }

    // MARK: Date

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .headerDateColor
        label.font = .headerDateFont
        return label
    }()

    private func set(date: String) {
        self.dateLabel.text = date
    }
}
