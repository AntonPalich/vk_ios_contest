//
//  NetworkService.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import VKSdkFramework

class NetworkService {

    private let apiUrl = "https://api.vk.com/method"
    private let apiVersion = "5.87"

    private let token: VKAccessToken
    private let session: URLSession = .shared
    private let comletionCallQueue: DispatchQueue = .main

    init(token: VKAccessToken) {
        self.token = token
    }

    func send(request: NetworkRequest, completion: @escaping (_ error: Error?) -> Void) {
        guard let url = self.makeUrl(for: request) else {
            assertionFailure("Can't build url for request")
            return
        }

        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let requestTask = self.session.dataTask(with: urlRequest) { (data, response, error) in
            defer {
                self.comletionCallQueue.async {
                    completion(error)
                }
            }

            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            if let response = json?["response"] as? [String: Any] {
                request.handle(response: response)
            }
        }
        requestTask.resume()
    }

    private func makeUrl(for request: NetworkRequest) -> URL? {
        var url = "\(self.apiUrl)/\(request.methodName)?"
        for (key, value) in request.methodParameters {
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                url.append("\(key)=\(encodedValue)&")
            }
        }
        url.append("access_token=\(self.token.accessToken!)&")
        url.append("v=\(self.apiVersion)")
        return URL(string: url)
    }
}
