//
//  NewsFeedViewModel.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

final class NewsFeedViewModel {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    private(set) var items: [NewsItem] = [] {
        didSet {
            self.itemsUpdatedCallback?()
        }
    }

    private(set) var profiles: [Int: Profile] = [:]
    private(set) var groups: [Int: Group] = [:]

    private var startFrom: String?

    func onViewDidLoad() {
        self.loadNextPage()
    }

    var isLoadingNextPage = false
    func loadNextPage() {
        guard !self.isLoadingNextPage else { return }
        self.isLoadingNextPage = true
        let request = GetNewsRequest(startFrom: self.startFrom)
        self.networkService.send(request: request) { [weak self] (_) in
            guard let sSelf = self else { return }
            sSelf.isLoadingNextPage = false
            guard let response = request.response else { return }
            sSelf.startFrom = response.nextFrom
            response.profiles.forEach { sSelf.profiles[$0.id] = $0 }
            response.groups.forEach { sSelf.groups[$0.id] = $0 }
            sSelf.items.append(contentsOf: response.items)
        }
    }

    var itemsUpdatedCallback: (() -> Void)?
}
