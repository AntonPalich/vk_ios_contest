//
//  NewsTableViewCell.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let placeholderImage = UIImage(color: UIColor.lightGray, size: CGSize(width: 36, height: 36))

    private let headerView = NewsHeaderView()
    private let barView = NewsBarView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.barView)

        self.headerView.viewModel = NewsHeaderView.ViewModel(
            avatarImage: NewsTableViewCell.placeholderImage,
            name: "Test Name",
            date: "Test Date"
        )

        self.barView.viewModel = NewsBarView.ViewModel(
            likes: "1",
            comments: "10",
            shares: "100",
            views: "1k",
            onLikesTapped: nil,
            onCommentsTapped: nil,
            onSharesTapped: nil
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var headerViewLayout = NewsHeaderViewLayout()
        headerViewLayout.calculateLayoutFitting(self.contentView.bounds.size)
        self.headerView.frame = CGRect(origin: .zero, size: headerViewLayout.size)

        var barViewLayout = NewsBarViewLayout()
        barViewLayout.calculateLayoutFitting(self.contentView.bounds.size)
        self.barView.frame = CGRect(origin: CGPoint(x: 0, y: self.headerView.frame.maxY), size: barViewLayout.size)
    }
}
