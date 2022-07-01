//
//  SignUpViewModelTests.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/27.
//

import XCTest
import Combine
@testable import PullgoKit

/// `SignUpViewModelTests` - Succeed Cases
///
/// `signUp()`
///   - `isStudent = true`일 경우 `signUpState`가 `.signedUp`이 되는지 확인
///   - `isStudent = false`일 경우 `signUpState`가 `.signedUp`이 되는지 확인
///
///  `requestVerificationNumber()`
///   - 호출하면 `verificationState`가 `.requested(String)`이 되는지 확인
///
///  `initializeVerification()`
///   - 호출하면 `verificationState`가 `.none`이 되는지 확인
///
///  `isUsernameExists()`
///   - `username`이 "username"일 경우 `usernameExistState`가 `.exists`가 되는지 확인
///   - `username`이 "username"이 아닐 경우 `usernameExistState`가 `.notExists`가 되는지 확인
class SucceedSignUpViewModelTests: XCTestCase {
    
    let viewModel = SignUpViewModel(signUpRepository: TestInstance.shared.succeedSignUpRepository)
    private var cancellables = Set<AnyCancellable>()
    
    func test_SignUpViewModel_signUpForStudent_shouldSetSignUpStateToSignedUp() {
        // Given
        let expectation = self.expectation()
        viewModel.isStudent = true
        
        // When
        var state: SignUpViewModel.SignUpState?
        viewModel.$signUpState
            .sink(receiveValue: { receivedState in
                if receivedState == .signedUp {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signUp()
        
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(state, .signedUp)
    }
    
    func test_SignUpViewModel_signUpForTeacher_shouldSetSignUpStateToSignedUp() {
        // Given
        let expectation = self.expectation()
        viewModel.isStudent = false
        
        // When
        var state: SignUpViewModel.SignUpState?
        viewModel.$signUpState
            .sink(receiveValue: { receivedState in
                if receivedState == .signedUp {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signUp()
        
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(state, .signedUp)
    }
    
    func test_SignUpViewModel_requestVerificationNumber_shouldSetVerificationStateToRequested() {
        // Given
        let expectation = self.expectation()
        
        // When
        var state: SignUpViewModel.PhoneVerificationState?
        viewModel.$verificationState
            .sink(receiveValue: { receivedState in
                if case .requested = receivedState {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.requestVerificationNumber()
        
        // Then
        wait(for: [expectation], timeout: 2)
        switch state {
            case .requested(let number):
                XCTAssertEqual(number, "1234")
            default:
                XCTFail("state must be requested.")
        }
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistsStateToExists_whenExistingUsernameGiven() {
        // Given
        let expectation = self.expectation()
        viewModel.username = "username"
        
        // When
        var state: SignUpViewModel.UsernameExistState?
        viewModel.$usernameExistState
            .sink(receiveValue: { receivedState in
                if receivedState == .exists {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.isUsernameExists()
        
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(state, .exists)
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistsStateToNotExists_whenNotExistingUsernameGiven() {
        // Given
        let expectation = self.expectation()
        viewModel.username = "notExists"
        
        // When
        var state: SignUpViewModel.UsernameExistState?
        viewModel.$usernameExistState
            .sink(receiveValue: { receivedState in
                if receivedState == .notExists {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.isUsernameExists()
        
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(state, .notExists)
    }
}

/// `SignUpViewModelTests` - Fail Cases
///
/// `signUp()`
///   - 에러 발생 시 `signUpState`가 `.failed`가 되고 `alert`를 방출하는지 확인
///
///  `requestVerificationNumber()`
///   - 에러 발생 시 `verificationState`가 `.none`이 되고 `alert`를 방출하는지 확인
///
///  `isUsernameExists()`
///   - 에러 발생 시 `usernameExistState`가 `.none`이 되고 `alert`를 방출하는지 확인
class FailSignUpViewModelTests: XCTestCase {
    
    let viewModel = SignUpViewModel(signUpRepository: TestInstance.shared.failSignUpRepository)
    private var cancellables = Set<AnyCancellable>()
    
    func test_SignUpViewModel_signUp_shouldSetSignedUpStateToFailed_andPublishAlert() {
        // Given
        let expectation = self.expectation()
        let alertExpectation = XCTestExpectation(description: "alert")
        viewModel.isStudent = .random()
        
        // When
        var state: SignUpViewModel.SignUpState?
        viewModel.$signUpState
            .sink(receiveValue: { receivedState in
                if receivedState == .none {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        var alert: AlertPublisher?
        viewModel.$alert
            .sink(receiveValue: { receivedAlert in
                alert = receivedAlert
                alertExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.signUp()
        
        // Then
        wait(for: [expectation, alertExpectation], timeout: 2)
        XCTAssertEqual(state, SignUpViewModel.SignUpState.none)
        XCTAssertNotNil(alert)
    }
    
    func test_SignUpViewModel_requestVerificationNumber_shouldSetVerificationStateToNone_andPublishAlert() {
        // Given
        let expectation = self.expectation()
        let alertExpectation = XCTestExpectation(description: "alert")
        
        // When
        var state: SignUpViewModel.PhoneVerificationState?
        viewModel.$verificationState
            .sink(receiveValue: { receivedState in
                if case .none = receivedState {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        var alert: AlertPublisher?
        viewModel.$alert
            .sink(receiveValue: { receivedAlert in
                alert = receivedAlert
                alertExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.requestVerificationNumber()
        
        // Then
        wait(for: [expectation, alertExpectation], timeout: 2)
        XCTAssertNotNil(state)
        XCTAssertNotNil(alert)
        switch state! {
            case SignUpViewModel.PhoneVerificationState.none:
                break
            default:
                XCTFail("state must be none.")
        }
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistStateToNone_andPublishAlert() {
        // Given
        let expectation = self.expectation()
        let alertExpectation = XCTestExpectation(description: "alert")
        viewModel.username = "username"
        
        // When
        var state: SignUpViewModel.UsernameExistState?
        viewModel.$usernameExistState
            .sink(receiveValue: { receivedState in
                if receivedState == .none {
                    state = receivedState
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        var alert: AlertPublisher?
        viewModel.$alert
            .sink(receiveValue: { receivedAlert in
                alert = receivedAlert
                alertExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.isUsernameExists()
        
        // Then
        wait(for: [expectation, alertExpectation], timeout: 2)
        XCTAssertNotNil(alert)
        XCTAssertEqual(state, SignUpViewModel.UsernameExistState.none)
    }
}
