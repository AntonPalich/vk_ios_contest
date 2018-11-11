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

    private let photoView: NewsSinglePhotoView = {
        let photoView = NewsSinglePhotoView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        return photoView
    }()

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
        self.contentView.addSubview(self.photoView)
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

    class ViewModel {
        let headerViewModel: NewsHeaderView.ViewModel
        let barViewModel: NewsBarView.ViewModel
        var textViewModel: NewsTextView.ViewModel
        let singlePhotoViewModel: NewsSinglePhotoViewModel?

        init(headerViewModel: NewsHeaderView.ViewModel,
             barViewModel: NewsBarView.ViewModel,
             textViewModel: NewsTextView.ViewModel,
             singlePhotoViewModel: NewsSinglePhotoViewModel?) {
            self.headerViewModel = headerViewModel
            self.barViewModel = barViewModel
            self.textViewModel = textViewModel
            self.singlePhotoViewModel = singlePhotoViewModel
        }
    }

    var viewModel: ViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.headerView.viewModel = viewModel.headerViewModel
                self.barView.viewModel = viewModel.barViewModel
                self.textView.viewModel = viewModel.textViewModel
                self.photoView.viewModel = viewModel.singlePhotoViewModel
            } else {
                self.headerView.viewModel = nil
                self.barView.viewModel = nil
                self.textView.viewModel = nil
                self.photoView.viewModel = nil
            }
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
        self.photoView.frame = self.layout.imageViewFrame
    }
}
