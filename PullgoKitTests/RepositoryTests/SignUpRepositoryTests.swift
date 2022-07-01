//
//  SignUpRepositoryTests.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/27.
//

import XCTest
import Combine
@testable import PullgoKit

/// `SignUpRepositoryTests` - Succeed Cases
///
/// `isStudentExists(username:)`
///   - `username`이 "username"이면 `exists`가 `true`인지 확인
///   - `username`이 "username"이 아니면 `exists`가 `false`인지 확인
///
/// `isTeacherExists(username:)`
///   - `username`이 "username"이면 `exists`가 `true`인지 확인
///   - `username`이 "username"이 아니면 `exists`가 `false`인지 확인
///
/// `signUp(student:)`
///   - 회원가입 성공 시 전달한 `student`가 반환되는지 확인
///
/// `signUp(teacher:)`
///   - 회원가입 성공 시 전달한 `teacher`가 반환되는지 확인
class SucceedSignUpRepositoryTests: XCTestCase {
    
    var repository: SignUpRepositoryProtocol!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        repository = SignUpRepository(dataStore: TestInstance.shared.succeedSignUpDataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        repository = nil
    }
    
    func test_SignUpRepository_isStudentExists_shouldReturnExistsTrue_whenExistingUsernameGiven() {
        // Given
        let username = "username"
        let expectation = self.expectation()
        
        // When
        var exist: Bool = false
        repository.isStudentExists(username: username)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedExists in
                    exist = receivedExists
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(exist)
    }
    
    func test_SignUpRepository_isStudentExists_shouldReturnExistsFalse_whenNotExistingUsernameGiven() {
        // Given
        let username = "notExists"
        let expectation = self.expectation()
        
        // When
        var exist: Bool = true
        repository.isStudentExists(username: username)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedExists in
                    exist = receivedExists
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertFalse(exist)
    }
    
    func test_SignUpRepository_isTeacherExists_shouldReturnExistsTrue_whenExistingUsernameGiven() {
        // Given
        let username = "username"
        let expectation = self.expectation()
        
        // When
        var exist: Bool = false
        repository.isTeacherExists(username: username)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedExists in
                    exist = receivedExists
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(exist)
    }
    
    func test_SignUpRepository_isTeacherExists_shouldReturnExistsFalse_whenNotExistingUsernameGiven() {
        // Given
        let username = "notExists"
        let expectation = self.expectation()
        
        // When
        var exist: Bool = true
        repository.isTeacherExists(username: username)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedExists in
                    exist = receivedExists
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertFalse(exist)
    }
    
    func test_SignUpRepository_signUpForStudent_shouldReturnGivenStudent() {
        // Given
        let expectation = self.expectation()
        let fakeStudent = TestInstance.shared.fakeStudent
        
        // When
        var student: Student?
        repository.signUp(student: fakeStudent)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedStudent in
                    student = receivedStudent
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(fakeStudent.account.username, student?.account.username)
        XCTAssertEqual(fakeStudent.account.fullName, student?.account.fullName)
        XCTAssertEqual(fakeStudent.account.phone, student?.account.phone)
    }
    
    func test_SignUpRepository_signUpForTeacher_shouldReturnGivenTeacher() {
        // Given
        let expectation = self.expectation()
        let fakeTeacher = TestInstance.shared.fakeTeacher
        
        // When
        var teacher: Teacher?
        repository.signUp(teacher: fakeTeacher)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedTeacher in
                    teacher = receivedTeacher
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(fakeTeacher.account.username, teacher?.account.username)
        XCTAssertEqual(fakeTeacher.account.fullName, teacher?.account.fullName)
        XCTAssertEqual(fakeTeacher.account.phone, teacher?.account.phone)
    }
}

/// `SignUpRepositoryTests` - Fail Cases
class FailSignUpRepositoryTests: XCTestCase {

    func test_UserSessionRepository_signUpForStudent_shouldReturnError() {
        // Given
        let expectation = self.expectation()
        let fakeStudent = TestInstance.shared.fakeStudent

        // When
        var error: Error?
        repository.signUp(student: fakeStudent)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            XCTFail("should return error.")
                        case .failure(let receivedError):
                            error = receivedError
                    }
                    expectation.fulfill()
                },
                receiveValue: failWhenReceiveValue
            )
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(error)
    }

    func test_UserSessionRepository_signUpForTeacher_shouldReturnError() {
        // Given
        let expectation = self.expectation()
        let fakeTeacher = TestInstance.shared.fakeTeacher

        // When
        var error: Error?
        repository.signUp(teacher: fakeTeacher)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            XCTFail("should return error.")
                        case .failure(let receivedError):
                            error = receivedError
                    }
                    expectation.fulfill()
                },
                receiveValue: failWhenReceiveValue
            )
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(error)
    }
}
