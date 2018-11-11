//
//  GetNewsResponse.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

struct GetNewsResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case nextFrom = "next_from"
        case items
        case profiles
        case groups
    }

    let nextFrom: String
    let items: [NewsItem]
    let profiles: [Profile]
    let groups: [Group]
}
