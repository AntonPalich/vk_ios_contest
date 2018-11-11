//
//  FooterCellController.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class FooterCellController: CellController {

    private let itemCount: Int

    init(itemCount: Int) {
        self.itemCount = itemCount
    }

    // MARK: CellController

    private static let reuseIdentifier = "FooterCell"

    static func register(in tableView: UITableView) {
        tableView.register(FooterCell.self, forCellReuseIdentifier: self.reuseIdentifier)
    }

    func dequeuCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: FooterCellController.reuseIdentifier, for: indexPath)
    }

    func heightForCell(in tableView: UITableView) -> CGFloat {
        return 40
    }

    func configure(cell: UITableViewCell) {
        guard let cell = cell as? FooterCell else { fatalError("wrong cell type") }
        cell.countLabel.text = String(format: NSLocalizedString("post.count", comment: ""), self.itemCount)
    }

    func onWillDisplayCell() {
    }

    func onDidEndDisplayingCell() {
    }
}
