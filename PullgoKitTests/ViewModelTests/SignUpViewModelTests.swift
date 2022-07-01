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
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_signUpForTeacher_shouldSetSignUpStateToSignedUp() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_requestVerificationNumber_shouldSetVerificationStateToRequested() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistsStateToExists_whenExistingUsernameGiven() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistsStateToNotExists_whenNotExistingUsernameGiven() {
        // Given
        
        // When
        
        // Then
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
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_requestVerificationNumber_shouldSetVerificationStateToNone_andPublishAlert() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_SignUpViewModel_isUsernameExists_shouldSetUsernameExistStateToNone_andPublishAlert() {
        // Given
        
        // When
        
        // Then
    }
}
