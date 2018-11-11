//
//  NetworkRequest.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    var methodName: String { get }
    var methodParameters: [String: String] { get }
    func handle(response: [String: Any])
}
