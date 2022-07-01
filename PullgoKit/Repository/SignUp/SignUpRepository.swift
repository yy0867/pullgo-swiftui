//
//  SignUpRepository.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine

public final class SignUpRepository: SignUpRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: SignUpDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: SignUpDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func isStudentExists(username: String) -> AnyPublisher<Bool, Error> {
        return dataStore.isStudentExists(username: username)
            .map(\.exists)
            .eraseToAnyPublisher()
    }
    
    public func isTeacherExists(username: String) -> AnyPublisher<Bool, Error> {
        return dataStore.isTeacherExists(username: username)
            .map(\.exists)
            .eraseToAnyPublisher()
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        return dataStore.signUp(student: student)
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        return dataStore.signUp(teacher: teacher)
    }
}
