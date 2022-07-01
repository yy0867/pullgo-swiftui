//
//  TestSignUp.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine
import NetworkKit
@testable import PullgoKit

class TestSignUpDataStore: SignUpDataStoreProtocol {
    
    // MARK: - Properties
    private let isSucceedCase: Bool
    
    // MARK: - Methods
    init(isSucceedCase: Bool) {
        self.isSucceedCase = isSucceedCase
    }
    
    /// `username`이 "username"일 때 `exists`는 `true`를 반환합니다.
    func isStudentExists(username: String) -> AnyPublisher<Exist, Error> {
        return Future<Exist, Error> { [weak self] promise in
            let result: Result<Exist, Error> = self!.isSucceedCase ? .success(Exist(exists: username == "username")) : .failure(NetworkError.invalidCode(code: 500))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func isTeacherExists(username: String) -> AnyPublisher<Exist, Error> {
        return Future<Exist, Error> { [weak self] promise in
            let result: Result<Exist, Error> = self!.isSucceedCase ? .success(Exist(exists: username == "username")) : .failure(NetworkError.invalidCode(code: 500))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp(student: Student) -> AnyPublisher<Student, Error> {
        return Future<Student, Error> { [weak self] promise in
            let result: Result<Student, Error> = self!.isSucceedCase ? .success(student) : .failure(NetworkError.invalidCode(code: 500))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        return Future<Teacher, Error> { [weak self] promise in
            let result: Result<Teacher, Error> = self!.isSucceedCase ? .success(teacher) : .failure(NetworkError.invalidCode(code: 500))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
}
