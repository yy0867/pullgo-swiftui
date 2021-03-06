//
//  Teacher.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

public struct Teacher: Codable {
    public let id: Int?
    public let account: Account
    
    init(id: Int? = nil, account: Account) {
        self.id = id
        self.account = account
    }
}

extension Teacher: Identifiable, Equatable {}

extension Teacher {
    public static func stub(id: Int? = nil, account: Account) -> Teacher {
        return Teacher(id: id, account: account)
    }
}
