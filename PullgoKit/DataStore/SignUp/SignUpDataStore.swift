//
//  SignUpDataStore.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine
import NetworkKit

public final class SignUpDataStore: SignUpDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func isStudentExists(username: String) -> AnyPublisher<Exist, Error> {
        let endpoint = Endpoint(paths: ["student", username, "exists"])
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Exist.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func isTeacherExists(username: String) -> AnyPublisher<Exist, Error> {
        let endpoint = Endpoint(paths: ["teacher", username, "exists"])
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Exist.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func signUp(student: Student) -> AnyPublisher<Student, Error> {
        var endpoint = Endpoint(httpMethod: .post, paths: ["students"])
        endpoint.setHTTPBody(student)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Student.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func signUp(teacher: Teacher) -> AnyPublisher<Teacher, Error> {
        var endpoint = Endpoint(httpMethod: .post, paths: ["teachers"])
        endpoint.setHTTPBody(teacher)
        
        return NetworkSession.shared.request(endpoint.toURLRequest())
            .decode(type: Teacher.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
