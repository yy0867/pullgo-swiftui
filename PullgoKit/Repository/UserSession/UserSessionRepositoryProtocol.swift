//
//  UserSessionRepositoryProtocol.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine

public protocol UserSessionRepositoryProtocol {
    func signIn(username: String, password: String) -> AnyPublisher<UserSession, Error>
    func rememberMe() -> AnyPublisher<UserSession?, Never>
    func signOut() -> AnyPublisher<Bool, Never>
}
