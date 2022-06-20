//
//  Endpoint.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

import Foundation

@propertyWrapper
struct Endpoint {
    
    private let baseURL = "https://pullgo.firstian.kr/api/v1"
    var wrappedValue: URLRequest
    
    init(httpMethod: HTTPMethod = .get, paths: [String], token: String? = nil) {
        var url = URL(string: baseURL)!
        paths.forEach { url.appendPathComponent($0) }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        self.wrappedValue = request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
