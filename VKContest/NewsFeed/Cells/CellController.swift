//
//  CellController.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

protocol CellController: AnyObject {
    static func register(in tableView: UITableView)
    func dequeuCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
    func heightForCell(in tableView: UITableView) -> CGFloat
    func configure(cell: UITableViewCell)
    func onWillDisplayCell()
    func onDidEndDisplayingCell()
}
