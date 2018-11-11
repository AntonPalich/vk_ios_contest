//
//  NewsItem.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

struct NewsItem: Decodable {
    let source_id: Int
    let type: String
    let date: TimeInterval
    let text: String
    let comments: NewsComments
    let likes: NewsLikes
    let reposts: NewsReposts
    let views: NewsViews?
}
