//
//  NewsFeedViewController.swift
//  VKContest
//
//  Created by Anton Schukin on 08/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsFeedViewController: UITableViewController {

    private let viewModel: NewsFeedViewModel
    private let imagesService: ImagesService

    init(viewModel: NewsFeedViewModel, imagesService: ImagesService) {
        self.viewModel = viewModel
        self.imagesService = imagesService

        super.init(nibName: nil, bundle: nil)

        self.viewModel.itemsUpdatedCallback = { [weak self] in
            self?.updateControllers()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = false
        self.tableView.backgroundColor = .newsBackgroundColor
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 0
        self.tableView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false

        NewsCellController.register(in: self.tableView)
        LoadingIndicatorCellController.register(in: self.tableView)

        self.viewModel.onViewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellControllers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellControllers[indexPath.row].heightForCell(in: tableView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellController = self.cellControllers[indexPath.row]
        let cell = cellController.dequeuCell(in: tableView, for: indexPath)
        cellController.configure(cell: cell)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cellControllers[indexPath.row].onWillDisplayCell()
    }

    // MARK: Controllers

    private var cellControllers: [CellController] = []

    private func updateControllers() {
        // Запоминаем данные для обновления
        let items = self.viewModel.items
        let profiles = self.viewModel.profiles
        let groups = self.viewModel.groups
        let layoutSize = CGSize(width: self.tableView.bounds.width, height: .greatestFiniteMagnitude)

        // FIXME: Сделать очередь обновлений. Создавать контроллеры в фоне
        DispatchQueue.global(qos: .userInitiated).async {
            var controllers: [CellController] = items.map { (item) in
                let controller: NewsCellController = {
                    if item.source_id >= 0 {
                        return NewsCellController(
                            item: item,
                            profile: profiles[item.source_id]!,
                            imagesService: self.imagesService
                        )
                    } else {
                        return NewsCellController(
                            item: item,
                            group: groups[abs(item.source_id)]!,
                            imagesService: self.imagesService
                        )
                    }
                }()
                controller.delegate = self
                controller.prepareLayout(fittingSize: layoutSize)
                return controller
            }
            controllers.append(LoadingIndicatorCellController(onDisplayed: {
                self.viewModel.loadNextPage()
            }))
            DispatchQueue.main.async {
                self.cellControllers = controllers
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsFeedViewController: NewsCellControllerDelegate {
    func controllerDidUpdateCell(_ controller: NewsCellController) {
        controller.invalidateLayout()
        self.tableView.reloadData()
    }
}
