//
//  NewsFeedViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 08/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsFeedViewController: UITableViewController {

    private let cellControllers = [
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController(),
        NewsCellController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "reuseId")
        self.tableView.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellControllers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellControllers[indexPath.row].heightForCell(in: tableView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        if let newsCell = cell as? NewsCell {
            self.cellControllers[indexPath.row].configure(cell: newsCell)
        }
        return cell
    }
}
