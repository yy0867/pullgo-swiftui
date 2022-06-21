//
//  UserSessionRepository.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine

public final class UserSessionRepository: UserSessionRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: UserSessionDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: UserSessionDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func signIn(credential: Credential) -> AnyPublisher<UserSession, Error> {
        return Fail(error: PullgoError.unknown)
            .eraseToAnyPublisher()
    }
    
    public func rememberMe() -> AnyPublisher<UserSession?, Never> {
        return Just(nil)
            .eraseToAnyPublisher()
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        return Fail(error: PullgoError.unknown)
            .eraseToAnyPublisher()
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        return Fail(error: PullgoError.unknown)
            .eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<Bool, Never> {
        return Just(false)
            .eraseToAnyPublisher()
    }
}
