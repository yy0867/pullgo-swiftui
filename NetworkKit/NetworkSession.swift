//
//  NetworkSession.swift
//  NetworkKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation
import Combine

public final class NetworkSession {
    
    // MARK: - Configure Singleton
    public static let shared = NetworkSession()
    private init() {}
    
    public func request(_ urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        Log.print("\(urlRequest.httpMethod ?? "No Method") request - \(urlRequest.url?.absoluteString ?? "nil.")")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse else {
                    Log.print("Cannot convert response to HTTPURLResponse.")
                    throw NetworkError.invalidResponse
                }
                guard (200..<300).contains(response.statusCode) else {
                    Log.print("Invalid status code: \(response.statusCode)")
                    throw NetworkError.invalidCode(code: response.statusCode)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    public func request(_ url: URL) -> AnyPublisher<Data, Error> {
        let urlRequest = URLRequest(url: url)
        return self.request(urlRequest)
    }
}
