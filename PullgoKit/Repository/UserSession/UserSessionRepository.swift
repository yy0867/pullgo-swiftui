//
//  UserSessionRepository.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
import NetworkKit

public final class UserSessionRepository: UserSessionRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: UserSessionDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: UserSessionDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func signIn(username: String, password: String) -> AnyPublisher<UserSession, Error> {
        let credential = Credential(username: username, password: password)
        return dataStore.signIn(credential: credential)
            .mapError(mapSignInFailError)
            .eraseToAnyPublisher()
    }
    
    public func rememberMe() -> AnyPublisher<UserSession?, Never> {
        return dataStore.rememberMe()
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        return dataStore.signUp(student: student)
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        return dataStore.signUp(teacher: teacher)
    }
    
    public func signOut() -> AnyPublisher<Bool, Never> {
        return dataStore.signOut()
    }
    
    // MARK: - Privates
    private func mapSignInFailError(_ error: Error) -> Error {
        guard let error = error as? NetworkError else {
            return error
        }
        
        if case .invalidCode(let code) = error,
           code == 401 {
            return PullgoError.signInFail
        } else {
            return PullgoError.networkError(error: error)
        }
    }
}
