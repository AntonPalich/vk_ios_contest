//
//  GetNewsRequest.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

class GetNewsRequest: NetworkRequest {

    let startFrom: String?

    init(startFrom: String?) {
        self.startFrom = startFrom
    }

    private(set) var response: GetNewsResponse?
    
    // MARK: NetworkRequest

    var methodName: String {
        return "newsfeed.get"
    }

    var methodParameters: [String : String] {
        var parameters = ["filters": "post"]
        if let startFrom = startFrom {
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
