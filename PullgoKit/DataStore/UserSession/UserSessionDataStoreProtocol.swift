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
    func signOut() -> AnyPublisher<Bool, Never>
}
