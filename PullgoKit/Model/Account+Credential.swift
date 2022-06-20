//
//  Account.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

public struct Account: Codable {
    public let username: String
    public let fullName: String
    public let phone: String
    public let password: String?
}

public struct Credential: Encodable {
    public let username: String
    public let password: String
}

extension Account: Equatable {}
extension Credential: Equatable {}
