//
//  UserSessionDataStore.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation
import Combine
import NetworkKit
import TokenKit

public final class UserSessionDataStore: UserSessionDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func signIn(credential: Credential) -> AnyPublisher<UserSession, Error> {
        var endpoint = Endpoint(httpMethod: .post, paths: ["auth", "token"])
        endpoint.setHTTPBody(credential)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: UserSession.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func rememberMe() -> AnyPublisher<UserSession?, Never> {
        let tokenManager = KeychainTokenManager()
        guard let token = tokenManager.readToken() else {
            return Future<UserSession?, Never> { promise in
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    let result: Result<UserSession?, Never> = .success(nil)
                    promise(result)
                }
            }
            .eraseToAnyPublisher()
        }
        
        var endpoint = Endpoint(paths: ["auth", "me"])
        endpoint.setAuthorization(with: token)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: UserSession?.self, decoder: JSONDecoder())
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<Bool, Never> {
        let tokenManager = KeychainTokenManager()
        let deleteStatus = tokenManager.delete()
        
        return Result.Publisher(deleteStatus)
            .eraseToAnyPublisher()
    }
}
