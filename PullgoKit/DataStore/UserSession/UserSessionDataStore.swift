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
            return Result.Publisher(nil)
                .eraseToAnyPublisher()
        }
        
        var endpoint = Endpoint(paths: ["auth", "me"])
        endpoint.setAuthorization(with: token)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: UserSession?.self, decoder: JSONDecoder())
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        var endpoint = Endpoint(httpMethod: .post, paths: ["students"])
        endpoint.setHTTPBody(student)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Student.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        var endpoint = Endpoint(httpMethod: .post, paths: ["teachers"])
        endpoint.setHTTPBody(teacher)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Teacher.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<Bool, Never> {
        let tokenManager = KeychainTokenManager()
        let deleteStatus = tokenManager.delete()
        
        return Result.Publisher(deleteStatus)
            .eraseToAnyPublisher()
    }
}
