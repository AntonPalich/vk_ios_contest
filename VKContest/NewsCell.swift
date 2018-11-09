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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.barView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    struct ViewModel {
        let headerViewModel: NewsHeaderView.ViewModel
        let barViewModel: NewsBarView.ViewModel
    }

    var viewModel: ViewModel? {
        didSet {
            self.headerView.viewModel = self.viewModel?.headerViewModel
            self.barView.viewModel = self.viewModel?.barViewModel
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
        self.headerView.frame = self.layout.headerViewFrame
        self.barView.frame = self.layout.barViewFrame
    }
}
