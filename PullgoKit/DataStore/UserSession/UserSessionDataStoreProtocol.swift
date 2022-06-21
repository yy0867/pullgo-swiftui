//
//  UserSessionDataStoreProtocol.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation
import Combine

public protocol UserSessionDataStoreProtocol {
    func signIn(credential: Credential) -> AnyPublisher<UserSession, Error>
    func rememberMe() -> AnyPublisher<UserSession?, Never>
    func signUp(student: Student) -> AnyPublisher<Student, Error>
    func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error>
    func signOut() -> AnyPublisher<Bool, Never>
}
