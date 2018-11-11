//
//  LoadingIndicatorCellController.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class LoadingIndicatorCellController: CellController {

    let onDisplayed: () -> Void

    init(onDisplayed: @escaping () -> Void) {
        self.onDisplayed = onDisplayed
    }

    // MARK: CellController

    static let reuseIdentifier = "LoadingIndicatorCell"
    
    static func register(in tableView: UITableView) {
        tableView.register(LoadingIndicatorCell.self, forCellReuseIdentifier: self.reuseIdentifier)
    }

    func dequeuCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: LoadingIndicatorCellController.reuseIdentifier, for: indexPath)
    }

    func heightForCell(in tableView: UITableView) -> CGFloat {
        return 40
    }

    func configure(cell: UITableViewCell) {
        guard let cell = cell as? LoadingIndicatorCell else { fatalError("wrong cell type") }
        self.cell = cell
    }

    private weak var cell: LoadingIndicatorCell?

    func onWillDisplayCell() {
        self.cell?.startAnimating()
        self.onDisplayed()
    }

    func onDidEndDisplayingCell() {
    }
}
