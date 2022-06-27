//
//  SignUpRepositoryProtocol.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine

public protocol SignUpRepositoryProtocol {
    func isStudentExists(username: String) -> AnyPublisher<Bool, Error>
    func isTeacherExists(username: String) -> AnyPublisher<Bool, Error>
    func signUp(student: Student) -> AnyPublisher<Student, Error>
    func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error>
}
