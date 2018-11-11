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

    init(viewModel: NewsFeedViewModel) {
        self.viewModel = viewModel
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
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "reuseId")
        self.tableView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false

        self.viewModel.onViewDidLoad()
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

    // MARK: Controllers

    private var cellControllers: [NewsCellController] = []

    private func updateControllers() {
        // Запоминаем данные для обновления
        let items = self.viewModel.items
        let profiles = self.viewModel.profiles
        let groups = self.viewModel.groups
        let layoutSize = CGSize(width: self.tableView.bounds.width, height: .greatestFiniteMagnitude)

        // FIXME: Сделать очередь обновлений. Создавать контроллеры в фоне
        DispatchQueue.global(qos: .userInitiated).async {
            var profilesMap: [Int: Profile] = [:]
            profiles.forEach { profilesMap[$0.id] = $0 }

            var groupsMap: [Int: Group] = [:]
            groups.forEach { groupsMap[$0.id] = $0 }
            
            let controllers: [NewsCellController] = items.map { (item) in
                let controller: NewsCellController = {
                    if item.source_id >= 0 {
                        return NewsCellController(item: item, profile: profilesMap[item.source_id]!)
                    } else {
                        return NewsCellController(item: item, group: groupsMap[abs(item.source_id)]!)
                    }
                }()
                controller.delegate = self
                controller.prepareLayout(fittingSize: layoutSize)
                return controller
            }
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
