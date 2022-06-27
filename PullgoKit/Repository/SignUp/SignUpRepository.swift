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
        
    }
    
    public func isTeacherExists(username: String) -> AnyPublisher<Bool, Error> {
        
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        
    }
}
