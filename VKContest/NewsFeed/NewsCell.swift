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
    private let textView = NewsTextView()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CardWithShadow")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // FIXME: Solve shadow problems
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.contentView.addSubview(self.backgroundImageView)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.textView)
        self.contentView.addSubview(self.barView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }

    // MARK: ViewModel

    struct ViewModel {
        let headerViewModel: NewsHeaderView.ViewModel
        let barViewModel: NewsBarView.ViewModel
        var textViewModel: NewsTextView.ViewModel
    }

    var viewModel: ViewModel? {
        didSet {
            self.headerView.viewModel = self.viewModel?.headerViewModel
            self.barView.viewModel = self.viewModel?.barViewModel
            self.textView.viewModel = self.viewModel?.textViewModel
        }
    }

    // MARK: Layout

    var layout = NewsCellLayout() {
        didSet {
            self.headerView.layout = self.layout.headerViewLayout
            self.barView.layout = self.layout.barViewLayout
            self.textView.layout = self.layout.textViewLayout
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
