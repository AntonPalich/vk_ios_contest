//
//  SearchNewsRequest.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

class SearchNewsRequest: NetworkRequest {

    let query: String
    let startFrom: String?

    init(query: String, startFrom: String?) {
        self.query = query
        self.startFrom = startFrom
    }

    private(set) var response: GetNewsResponse?

    // MARK: NetworkRequest

    var methodName: String {
        return "newsfeed.search"
    }

    var methodParameters: [String : String] {
        var parameters = [
            "q": self.query,
            "extended": "1"
        ]
        if let startFrom = self.startFrom {
            parameters["start_from"] = startFrom
        }
        return parameters
    }

    func handle(response: [String : Any]) {
        do {
            // Перегоняем обратно в data, чтобы использовать Decodable. Нет времени на правильное решение
            let json = try JSONSerialization.data(withJSONObject: response, options: [])
            let decoder = JSONDecoder()
            self.response = try decoder.decode(GetNewsResponse.self, from: json)
        } catch let error {
            print(error)
        }
    }
}
