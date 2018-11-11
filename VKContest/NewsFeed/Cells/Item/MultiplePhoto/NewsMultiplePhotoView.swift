//
//  NewsMultiplePhotoView.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsMultiplePhotoView: UIView {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private let pageIndicator: UIPageControl = {
        let pageIndicator = UIPageControl()
        pageIndicator.pageIndicatorTintColor = UIColor(hex: 0xC7D6E8)
        pageIndicator.currentPageIndicatorTintColor = UIColor(hex: 0x5181B8)
        pageIndicator.currentPage = 0
        pageIndicator.numberOfPages = 5
        return pageIndicator
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xD7D8D9)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView.register(NewsMultiplePhotoViewCell.self,
                                     forCellWithReuseIdentifier: "NewsMultiplePhotoViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.addSubview(self.collectionView)
        self.addSubview(self.pageIndicator)
        self.addSubview(self.separatorView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewModel

    var viewModels: [NewsSinglePhotoViewModel]? {
        didSet {
            self.pageIndicator.currentPage = 0
            self.pageIndicator.numberOfPages = self.viewModels?.count ?? 0
            self.collectionView.contentOffset = .zero
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Layout

    var layout = NewsMultiplePhotoViewLayout() {
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.layout.collectionViewFrame
        self.pageIndicator.frame = self.layout.pageIndicatorFrame
        self.separatorView.frame = self.layout.separatorFrame
    }
}

extension NewsMultiplePhotoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModels?[indexPath.row].onWillDisplay()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        self.pageIndicator.currentPage = Int((scrollView.contentOffset.x + (0.5 * width)) / width);
    }
}

extension NewsMultiplePhotoView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsMultiplePhotoViewCell", for: indexPath)
        if let cell = cell as? NewsMultiplePhotoViewCell {
            cell.photoView.viewModel = self.viewModels?[indexPath.row]
        }
        return cell
    }
}
