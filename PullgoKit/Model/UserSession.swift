//
//  UserSession.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

public struct UserSession: Codable {
    public let token: String?
    public let student: Student?
    public let teacher: Teacher?
}

extension UserSession: Equatable {}

extension UserSession {
    public static func stub(
        token: String?,
        student: Student? = nil,
        teacher: Teacher? = nil
    ) -> UserSession {
        return UserSession(token: token, student: student, teacher: teacher)
    }
}
