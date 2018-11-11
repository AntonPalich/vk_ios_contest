//
//  NewsFeedContainerViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsFeedContainerViewController: UIViewController {

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
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.newsFeedViewController?.view.frame = self.view.bounds
    }
}
