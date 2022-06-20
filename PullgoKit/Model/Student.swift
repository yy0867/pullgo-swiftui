//
//  Student.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

public struct Student: Codable {
    public let id: Int?
    public let account: Account
    public let parentPhone: String
    public let schoolName: String
    public let schoolYear: Int
}

extension Student: Identifiable, Equatable {}
