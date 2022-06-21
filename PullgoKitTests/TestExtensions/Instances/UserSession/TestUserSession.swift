//
//  TestUserSession.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
@testable import PullgoKit

class TestUserSessionDataStore: UserSessionDataStoreProtocol {
    
    // MARK: - Properties
    private let isSucceedCase: Bool
    
    let fakeStudent = Student(
        id: 1,
        account: Account(
            username: "student",
            fullName: "student",
            phone: "01012345678",
            password: "12345678"
        ),
        parentPhone: "01087654321",
        schoolName: "schoolname",
        schoolYear: 1
    )
    
    let fakeTeacher = Teacher(
        id: 1,
        account: Account(
            username: "teacher",
            fullName: "teacher",
            phone: "01012345678",
            password: "12345678"
        )
    )
    
    // MARK: - Methods
    init(isSucceedCase: Bool) {
        self.isSucceedCase = isSucceedCase
    }
    
    func signIn(credential: Credential) -> AnyPublisher<UserSession, Error> {
        if !isSucceedCase {
            // 에러 반환 (401 제외)
            return Fail(error: PullgoError.networkError(error: .invalidCode(code: 500)))
                .eraseToAnyPublisher()
        } else {
            if credential.username == "student" {
                // 학생 계정 반환
                return Result.Publisher(UserSession(token: "token", student: fakeStudent, teacher: nil))
                    .eraseToAnyPublisher()
            } else if credential.username == "teacher" {
                // 선생님 계정 반환
                return Result.Publisher(UserSession(token: "token", student: nil, teacher: fakeTeacher))
                    .eraseToAnyPublisher()
            } else {
                // 로그인 실패 (401)
                return Fail(error: PullgoError.networkError(error: .invalidCode(code: 401)))
                    .eraseToAnyPublisher()
            }
        }
    }
    
    /// `Student`를 담고 있는 `UserSession`를 반환합니다.
    /// - Returns: 성공 시 `TestUserSession.fakeStudent`로 구성된 `UserSession`
    func rememberMe() -> AnyPublisher<UserSession?, Never> {
        if !isSucceedCase {
            // nil 반환
            return Just(nil)
                .eraseToAnyPublisher()
        } else {
            // fakeStudent 반환
            return Just(UserSession(token: "token", student: fakeStudent, teacher: nil))
                .eraseToAnyPublisher()
        }
    }
    
    func signUp(student: Student) -> AnyPublisher<Student, Error> {
        if !isSucceedCase {
            return Fail(error: PullgoError.networkError(error: .invalidCode(code: 400)))
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(student)
                .eraseToAnyPublisher()
        }
    }
    
    func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        if !isSucceedCase {
            return Fail(error: PullgoError.networkError(error: .invalidCode(code: 400)))
                .eraseToAnyPublisher()
        } else {
            return Result.Publisher(teacher)
                .eraseToAnyPublisher()
        }
    }
    
    func signOut() -> AnyPublisher<Bool, Never> {
        return Just(isSucceedCase)
            .eraseToAnyPublisher()
    }
}
