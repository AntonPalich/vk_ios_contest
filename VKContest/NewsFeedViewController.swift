//
//  NewsFeedViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 08/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsFeedViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.keyboardDismissMode = .onDrag

        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "reuseId")

        self.tableView.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var headerViewLayout = NewsHeaderViewLayout()
        headerViewLayout.calculateLayoutFitting(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude))
        var barViewlayout = NewsBarViewLayout()
        barViewlayout.calculateLayoutFitting(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude))
        return headerViewLayout.size.height + barViewlayout.size.height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        return cell
    }
}
