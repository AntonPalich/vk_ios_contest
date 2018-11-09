//
//  NewsCellController.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsCellController {

    static let placeholderImage = UIImage(color: UIColor.lightGray, size: CGSize(width: 36, height: 36))

    private var cellLayout = NewsCellLayout()

    func heightForCell(in tableView: UITableView) -> CGFloat {
        self.cellLayout.calculateLayoutFitting(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude))
        return self.cellLayout.size.height
    }

    func configure(cell: NewsCell) {
        cell.viewModel = NewsCell.ViewModel(
            headerViewModel: NewsHeaderView.ViewModel(
                avatarImage: NewsCellController.placeholderImage,
                name: "Test Name",
                date: "Test Date"
            ),
            barViewModel: NewsBarView.ViewModel(
                likes: "1",
                comments: "10",
                shares: "100",
                views: "1k",
                onLikesTapped: nil,
                onCommentsTapped: nil,
                onSharesTapped: nil
            )
        )
        cell.layout = self.cellLayout
    }
}
