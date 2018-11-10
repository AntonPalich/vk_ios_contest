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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.definesPresentationContext = true

        self.searchController = UISearchController(searchResultsController: NewsFeedViewController())
        self.searchController?.searchBar.searchBarStyle = .minimal
        self.searchController?.dimsBackgroundDuringPresentation = false

        let newsFeedViewController = NewsFeedViewController()
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
