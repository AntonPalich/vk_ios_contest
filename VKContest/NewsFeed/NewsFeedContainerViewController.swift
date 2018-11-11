//
//  NewsFeedContainerViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsFeedContainerViewController: UIViewController {

    private var topView = UIView()
    private var searchController: UISearchController?
    private var newsFeedViewController: NewsFeedViewController?

    private let networkService: NetworkService
    private let imagesService: ImagesService

    init(networkService: NetworkService, imagesService: ImagesService) {
        self.networkService = networkService
        self.imagesService = imagesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.definesPresentationContext = true

        self.searchController = UISearchController(
            searchResultsController: NewsFeedViewController(
                viewModel: NewsFeedViewModel(networkService: self.networkService),
                imagesService: self.imagesService
            )
        )
        self.searchController?.searchBar.searchBarStyle = .minimal
        self.searchController?.dimsBackgroundDuringPresentation = false

        let newsFeedViewController = NewsFeedViewController(
            viewModel: NewsFeedViewModel(
                networkService: self.networkService
            ),
            imagesService: self.imagesService
        )
        self.vk_addSubview(from: newsFeedViewController)
        newsFeedViewController.view.frame = self.view.bounds
        newsFeedViewController.tableView.tableHeaderView = self.searchController?.searchBar
        self.newsFeedViewController = newsFeedViewController

        self.topView.backgroundColor = UIColor(hex: 0xFCFCFC)
        self.topView.layer.shadowOpacity = 0.5
        self.topView.layer.masksToBounds = false
        self.view.addSubview(self.topView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaTop: CGFloat = {
            if #available(iOS 11.0, *) {
                return self.view.safeAreaInsets.top
            } else {
                return self.topLayoutGuide.length
            }
        }()
        self.topView.frame = CGRect(
            origin: .zero,
            size: CGSize(width: self.view.bounds.width, height: safeAreaTop)
        )
        self.newsFeedViewController?.view.frame = self.view.bounds
    }
}
