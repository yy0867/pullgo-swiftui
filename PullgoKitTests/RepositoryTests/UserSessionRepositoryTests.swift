//
//  UserSessionRepositoryTests.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/21.
//

import XCTest
import Combine
@testable import PullgoKit

/// `UserSessionRepositoryTests` - Succeed Cases
///
/// `signIn(credential:)`
///   - "student"로 로그인 시 `Student`로 구성된 `UserSession` 반환
///   - "teacher"로 로그인 시 `Teacher`로 구성된 `UserSession` 반환
///
/// `rememberMe()`
///   - 호출 시 `UserSession` 반환
///
/// `signUp(student:)`
///   - 회원가입 시 해당 `Student` 반환
///
/// `signUp(teacher:)`
///   - 회원가입 시 해당 `Teacher` 반환
///
/// `signOut()`
///   - 호출 시 `true` 반환
class SucceedUserSessionRepositoryTests: XCTestCase {
    
    var repository: UserSessionRepositoryProtocol!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        self.repository = UserSessionRepository(
            dataStore: TestUserSessionDataStore(isSucceedCase: true)
        )
    }
    
    func test_UserSessionRepository_signInForStudent_shouldReturnUserSession_ConfiguredByStudent() {
        // Given
        let credential = Credential(username: "student", password: "12345678")
        let expectation = self.expectation()
        
        // When
        var userSession: UserSession?
        repository.signIn(credential: credential)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedUserSession in
                    userSession = receivedUserSession
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(credential.username, userSession?.student?.account.username)
    }
    
    func test_UserSessionRepository_signInForTeacher_shouldReturnUserSession_ConfiguredByTeacher() {
        // Given
        let credential = Credential(username: "teacher", password: "12345678")
        let expectation = self.expectation()
        
        // When
        var userSession: UserSession?
        repository.signIn(credential: credential)
            .sink(
                receiveCompletion: failWhenReceiveError,
                receiveValue: { receivedUserSession in
                    userSession = receivedUserSession
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(credential.username, userSession?.teacher?.account.username)
    }
    
    func test_UserSessionRepository_rememberMe_shouldReturnUserSession() {
        // Given
        let expectation = self.expectation()
        
        // When
        var userSession: UserSession?
        repository.rememberMe()
            .sink(receiveValue: { receivedUserSession in
                userSession = receivedUserSession
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(userSession)
        XCTAssertEqual("token", userSession?.token)
    }
    
    func test_UserSessionRepository_signUpForStudent_shouldReturnSignedUpStudent() {
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
    
    func test_UserSessionRepository_signUpForTeacher_shouldReturnSignedUpTeacher() {
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
    
    func test_UserSessionRepository_signOut_shouldReturnTrue() {
        // Given
        let expectation = self.expectation()
        
        // When
        var returnValue: Bool = false
        repository.signOut()
            .sink(receiveValue: { receivedValue in
                returnValue = receivedValue
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(returnValue)
    }
}

/// `UserSessionRepositoryTests` - Fail Cases
///
/// `signIn(credential:)`
///   - 존재하지 않는 계정으로 로그인 시도하면 `signInFail` 에러 반환
///   - 다른 에러가 발생하면 `signInFail`을 **제외한** 에러 반환
///
/// `rememberMe()`
///   - 호출 시 `nil` 반환
///
/// `signUp(student:)`
///   - 회원가입 시 에러 반환
///
/// `signUp(teacher:)`
///   - 회원가입 시 에러 반환
///
/// `signOut()`
///   - 호출 시 `false` 반환
class FailUserSessionRepositoryTests: XCTestCase {
    
    var repository: UserSessionRepositoryProtocol!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        self.repository = UserSessionRepository(
            dataStore: TestUserSessionDataStore(isSucceedCase: false)
        )
    }
    
    func test_UserSessionRepository_signInFail_accountNotExist_shouldReturnSignInFailError() {
        // Given
        let credential = Credential(username: "usernameNotExists", password: "12345678")
        let expectation = self.expectation()
        
        // When
        var error: Error?
        repository.signIn(credential: credential)
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
        XCTAssertNotNil(error as? PullgoError)
        if case .signInFail = (error as! PullgoError) {
            return
        } else {
            XCTFail("error should be signInFail.\nreceivedError: \(error?.localizedDescription ?? "nil.")")
        }
    }
    
    func test_UserSessionRepository_signInFail_notSignInFailError_shouldReturnErrorExceptSignInFailError() {
        // Given
        let credential = Credential(username: "student", password: "12345678")
        let expectation = self.expectation()
        
        // When
        var error: Error?
        repository.signIn(credential: credential)
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
        if let error = error as? PullgoError {
            if case .signInFail = error {
                XCTFail("error should not be signInFail.")
            }
        }
    }
    
    func test_UserSessionRepository_rememberMe_shouldReturnNil() {
        // Given
        let expectation = self.expectation()
        
        // When
        var userSession: UserSession? = UserSession(token: nil, student: nil, teacher: nil)
        repository.rememberMe()
            .sink(receiveValue: { receivedUserSession in
                userSession = receivedUserSession
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNil(userSession)
    }
    
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
    
    func test_UserSessionRepository_signOut_shouldReturnFalse() {
        // Given
        let expectation = self.expectation()
        
        // When
        var returnValue: Bool = true
        repository.signOut()
            .sink(receiveValue: { receivedValue in
                returnValue = receivedValue
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertFalse(returnValue)
    }
}
