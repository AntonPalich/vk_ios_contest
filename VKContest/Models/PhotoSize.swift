//
//  PhotoSize.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
