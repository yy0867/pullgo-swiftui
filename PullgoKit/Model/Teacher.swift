//
//  Teacher.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

public struct Teacher: Codable {
    public let id: Int?
    public let account: Account
}

extension Teacher: Identifiable, Equatable {}
