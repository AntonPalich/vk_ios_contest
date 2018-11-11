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

    private(set) var profiles: [Profile] = []
    private(set) var groups: [Group] = []

    func onViewDidLoad() {
        let request = GetNewsRequest(startFrom: nil)
        self.networkService.send(request: request) { [weak self] (_) in
            guard let sSelf = self else { return }
            guard let response = request.response else { return }
            sSelf.profiles = response.profiles
            sSelf.groups = response.groups
            sSelf.items = response.items
        }
    }

    var itemsUpdatedCallback: (() -> Void)?
}
