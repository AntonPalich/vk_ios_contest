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

    weak var delegate: NewsCellControllerDelegate?

    private let item: NewsItem
    private let avatarURL: String
    private let imagesService: ImagesService

    init(item: NewsItem, profile: Profile, imagesService: ImagesService) {
        self.item = item
        self.avatarURL = profile.photoUrl
        self.imagesService = imagesService

        self.viewModel = NewsCell.ViewModel(
            headerViewModel: self.makeHeaderViewModel(from: item, profile: profile),
            barViewModel: self.makeBarViewModel(from: item),
            textViewModel: self.makeTextViewModel(from: item)
        )
    }

    init(item: NewsItem, group: Group, imagesService: ImagesService) {
        self.item = item
        self.avatarURL = group.photoUrl
        self.imagesService = imagesService

        self.viewModel = NewsCell.ViewModel(
            headerViewModel: self.makeHeaderViewModel(from: item, group: group),
            barViewModel: self.makeBarViewModel(from: item),
            textViewModel: self.makeTextViewModel(from: item)
        )
    }

    // MARK: - Cell configuration

    private var isLayoutInvalidated = false
    private var layout = NewsCellLayout()

    func prepareLayout(fittingSize size: CGSize) {
        var layout = NewsCellLayout()
        layout.calculateLayoutFitting(size, for: self.viewModel!) // убрать !
        self.layout = layout
    }

    func invalidateLayout() {
        self.isLayoutInvalidated = true
    }

    func heightForCell(in tableView: UITableView) -> CGFloat {
        if self.isLayoutInvalidated {
            let size = CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)
            self.prepareLayout(fittingSize: size)
        }
        return self.layout.size.height
    }

    func configure(cell: NewsCell) {
        cell.viewModel = self.viewModel
        cell.layout = self.layout
    }

    func willDisplay() {
        if let url = URL(string: self.avatarURL) {
            self.imagesService.loadImage(from: url) { (image) in
                self.viewModel?.headerViewModel.avatarImage.value = image
            }
        }
    }
    
    // MARK: - View Models

    private var viewModel: NewsCell.ViewModel?

    private func makeHeaderViewModel(from item: NewsItem, profile: Profile) -> NewsHeaderView.ViewModel {
        return NewsHeaderView.ViewModel(
            name: "\(profile.firstName) \(profile.lastName)",
            date: NewsCellController.dateFormatter.string(from: Date(timeIntervalSince1970: item.date))
        )
    }

    private func makeHeaderViewModel(from item: NewsItem, group: Group) -> NewsHeaderView.ViewModel {
        return NewsHeaderView.ViewModel(
            name: "\(group.name)",
            date: NewsCellController.dateFormatter.string(from: Date(timeIntervalSince1970: item.date))
        )
    }

    private func makeTextViewModel(from item: NewsItem) -> NewsTextView.ViewModel {
        return NewsTextView.ViewModel(
            state: .short,
            text: NSAttributedString(
                string: item.text,
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
    }

    private func makeBarViewModel(from item: NewsItem) -> NewsBarView.ViewModel {
        return NewsBarView.ViewModel(
            likes: item.likes.count > 0 ? "\(item.likes.count)" : "",
            comments: item.comments.count > 0 ? "\(item.comments.count)" : "",
            shares: item.reposts.count > 0 ? "\(item.reposts.count)" : "",
            views: {
                if let views = item.views {
                    return views.count > 0 ? "\(views.count.kFormatted)" : ""
                } else {
                    return ""
                }
            }(),
            onLikesTapped: nil,
            onCommentsTapped: nil,
            onSharesTapped: nil
        )
    }

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM в HH:mm"
        return dateFormatter
    }()
}
