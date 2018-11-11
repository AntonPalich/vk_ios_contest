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

    class ViewModel {

        static let avatarPlaceholder = UIImage(color: UIColor.lightGray, size: CGSize(width: 36, height: 36))
        var avatarImage = Observable<UIImage?>(ViewModel.avatarPlaceholder)

        let name: String
        let date: String

        init(name: String, date: String) {
            self.name = name
            self.date = date
        }
    }

    var viewModel: ViewModel? {
        didSet {
            self.update()
        }
    }

    private func update() {
        if let viewModel = self.viewModel {
            self.set(avatarImage: viewModel.avatarImage.value)
            self.set(name: viewModel.name)
            self.set(date: viewModel.date)
            self.avatarImageObserver = viewModel.avatarImage.observe { [weak self] (_, newAvatar) in
                self?.set(avatarImage: newAvatar)
            }
        } else {
            self.set(avatarImage: nil)
            self.set(name: "")
            self.set(date: "")
            self.avatarImageObserver = nil
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

    private var avatarImageObserver: AnyObject?

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
