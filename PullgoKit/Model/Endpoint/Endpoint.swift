//
//  Endpoint.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation

struct Endpoint {
    
    // MARK: - Properties
    private let baseURI = URL(string: "https://pullgo.firstian.kr/api/v1")!
    private let paths: [String]
    private let queries: [URLQueryItem]
    private let httpMethod: HTTPMethod
    
    private var httpBody: Data? = nil
    private var bearerToken: String? = nil
    
    // MARK: - Methods
    init(httpMethod: HTTPMethod = .get, paths: [String], queries: [URLQueryItem] = []) {
        self.paths = paths
        self.httpMethod = httpMethod
        self.queries = queries
    }
    
    mutating func setAuthorization(with bearerToken: String) {
        self.bearerToken = bearerToken
    }
    
    mutating func setHTTPBody(_ encodable: Encodable) {
        self.httpBody = encodable.toData()
    }
    
    func toURLRequest() -> URLRequest {
        var url = baseURI
        for path in paths { url.appendPathComponent(path) }
        
        var urlComponents = URLComponents(string: url.absoluteString)!
        urlComponents.queryItems = queries
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        if let bearerToken = bearerToken {
            urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}

fileprivate extension Encodable {
    func toData() -> Data? {
        guard let data = try? JSONEncoder().encode(self) else {
            Log.print("Fail to encode http body.")
            return nil
        }
        return data
    }
}
