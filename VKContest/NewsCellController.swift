//
//  NewsCellController.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

protocol NewsCellControllerDelegate: AnyObject {
    func controllerDidUpdateCell(_ controller: NewsCellController)
}

class NewsCellController {

    init() {
        self.viewModel = NewsCell.ViewModel(
            headerViewModel: NewsHeaderView.ViewModel(
                avatarImage: NewsCellController.placeholderImage,
                name: "Андрей Рогозов",
                date: "9 апр в 16:36"
            ),
            barViewModel: NewsBarView.ViewModel(
                likes: "1",
                comments: "10",
                shares: "100",
                views: "1k",
                onLikesTapped: nil,
                onCommentsTapped: nil,
                onSharesTapped: nil
            ),
            textViewModel: NewsTextView.ViewModel(
                state: .short,
                text: NSAttributedString(
                    string: self.text,
                    attributes: [
                        .font: UIFont.newsTextFont,
                        .foregroundColor: UIColor.newsTextColor,
                        .paragraphStyle: {
                            let paragraphStyle = NSMutableParagraphStyle()
                            paragraphStyle.lineSpacing = 4
                            return paragraphStyle
                        }()
                    ]
                ),
                onShowMoreTapped: { [weak self] in
                    guard let sSelf = self else { return }
                    sSelf.viewModel?.textViewModel.state = .full
                    sSelf.delegate?.controllerDidUpdateCell(sSelf)
                }
            )
        )
    }

    static let placeholderImage = UIImage(color: UIColor.lightGray, size: CGSize(width: 36, height: 36))

    weak var delegate: NewsCellControllerDelegate?
    
    private var cellLayout = NewsCellLayout()
    private let text = "Одной из ключевых ценностей Вконтакте является то, что здесь сосредоточено огромное количество уникального контента. Сотни тысяч авторов и пабликов ежедневно создают миллионы материалов, которые невозможно найти нигде, кроме Вконтакте. Одной из ключевых ценностей Вконтакте является то, что здесь сосредоточено огромное количество уникального контента. Сотни тысяч авторов и пабликов ежедневно создают миллионы материалов, которые невозможно найти нигде, кроме Вконтакте."

//    private let text = "1\n2\n3\n4\n5\n6\n7\n8\n9"

    func heightForCell(in tableView: UITableView) -> CGFloat {
        self.cellLayout.calculateLayoutFitting(
            CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude),
            for: self.viewModel! // убрать !
        )
        return self.cellLayout.size.height
    }

    private var viewModel: NewsCell.ViewModel?

    func configure(cell: NewsCell) {
        cell.viewModel = self.viewModel
        cell.layout = self.cellLayout
    }
}
