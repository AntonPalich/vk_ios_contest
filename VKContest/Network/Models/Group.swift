//
//  Group.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

struct Group: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoUrl = "photo_50"
    }

    let id: Int
    let name: String
    let photoUrl: String
}
