//
//  OnboardingViewModelTests.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/23.
//

import XCTest
import Combine
@testable import PullgoKit

/// `OnboardingViewModelTests` - Succeed Cases
///
/// `signIn()`
///   - 로그인 성공 시 `signingState`가 `.completed(UserSession)`이 되는지 확인
///   - 로그인 성공 시 `userSessionDelegate`의 `signedIn`이 호출되어,
///   `LaunchViewModel`의 `appState`가 `.running(.authenticated(UserSession))`이 되는지 확인
///
/// `Credential`
///   - `username`과 `password`가 모두 비어있지 않을 때 `signingState`가 `.valid`가 되는지 확인
///   - `username`이 비어 있을 때 `signingState`가 `.invalid`인지 확인
///   - `password`가 비어 있을 때 `signingState`가 `.invalid`인지 확인
class SucceedOnboardingViewModelTests: XCTestCase {

    var viewModel: OnboardingViewModel!
    var cancellables = Set<AnyCancellable>()
    
    let userSessionRepository = TestInstance.shared.succeedUserSessionRepository
    lazy var userSessionDelegate: LaunchViewModel = {
        return LaunchViewModel(userSessionRepository: userSessionRepository)
    }()
    
    override func setUp() {
        super.setUp()
        
        userSessionDelegate.signOut()
        
        self.viewModel = OnboardingViewModel(
            userSessionRepository: userSessionRepository,
            userSessionDelegate: userSessionDelegate
        )
    }
    
    override func tearDown() {
        super.tearDown()
        self.cancellables.removeAll()
        self.viewModel = nil
    }
    
    func test_OnboardingViewModel_signIn_shouldChangeSigingStateToCompleted_andAppStateToAuthenticated_withUserSessionAssociatedValue() {
        // Given
        let expectation = self.expectation()
        viewModel.username = "student"
        viewModel.password = "password"
        
        // When
        viewModel.$signingState
            .sink(receiveValue: { receivedSigingState in
                if case .completed = receivedSigingState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signIn()
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .running(.authenticated) = userSessionDelegate.appState,
           case .completed = viewModel.signingState {
            return
        } else {
            XCTFail("Incorrect state detected.")
        }
    }
    
    func test_OnboardingViewModel_signInState_shouldValidWhenAllFieldsAreNotEmpty() {
        // Given
        let expectation = self.expectation()
        
        // When
        viewModel.$signingState
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { receivedSigningState in
                if case .valid = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.username = "username"
        viewModel.password = "password"
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .valid = viewModel.signingState {
            return
        } else {
            XCTFail("Incorrect state detected.")
        }
    }
    
    func test_OnboardingViewModel_signInState_shouldInvalidWhenUsernameFieldIsEmpty() {
        // Given
        let expectation = self.expectation()
        
        // When
        viewModel.$signingState
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { receivedSigningState in
                if case .invalid = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.username = ""
        viewModel.password = "password"
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .invalid = viewModel.signingState {
            return
        } else {
            XCTFail("Incorrect state detected.")
        }
    }
    
    func test_OnboardingViewModel_signInState_shouldInvalidWhenPasswordFieldIsEmpty() {
        // Given
        let expectation = self.expectation()
        
        // When
        viewModel.$signingState
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { receivedSigningState in
                if case .invalid = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.username = "username"
        viewModel.password = ""
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .invalid = viewModel.signingState {
            return
        } else {
            XCTFail("Incorrect state detected.")
        }
    }
}

/// `OnboardingViewModelTests` - Fail Cases
///
/// `signIn()`
///   - 아이디 및 비밀번호가 비어있으면 `signingState`가 `.invalid`인지 확인
///   - 존재하지 않는 아이디로 로그인에 실패하면 `signingState`가 `.failed(.accountNotExists)`이 되는지 확인
///   - 오류로 인해 로그인에 실패하면 `signingState`가 `.failed(.errorDetected)`가 되는지 확인
class FailOnboardingViewModelTests: XCTestCase {
    
    var viewModel: OnboardingViewModel!
    var cancellables = Set<AnyCancellable>()
    
    let userSessionRepository = TestInstance.shared.failUserSessionRepository
    lazy var userSessionDelegate: LaunchViewModel = {
        return LaunchViewModel(userSessionRepository: userSessionRepository)
    }()
    
    override func setUp() {
        super.setUp()
        
        userSessionDelegate.signOut()
        
        self.viewModel = OnboardingViewModel(
            userSessionRepository: userSessionRepository,
            userSessionDelegate: userSessionDelegate
        )
    }
    
    override func tearDown() {
        super.tearDown()
        self.cancellables.removeAll()
        self.viewModel = nil
    }
    
    func test_OnboardingViewModel_signIn_shouldChangeSigningStateToInvalid_whenUsernameAndPasswordIsEmpty() {
        // Given
        let expectation = self.expectation()
        viewModel.username = ""
        viewModel.password = ""
        
        // When
        viewModel.$signingState
            .sink(receiveValue: { receivedSigningState in
                if case .invalid = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signIn()
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .invalid = viewModel.signingState {
            return
        } else {
            XCTFail("expected signing state was invalid.")
        }
    }
    
    func test_OnboardingViewModel_signIn_shouldChangeSigningStateToFailed_withAccountNotExistsAssociatedValue_whenGivenAccountIsNotExists() {
        // Given
        let expectation = self.expectation()
        viewModel.username = "usernameNotExists"
        viewModel.password = "password"
        
        // When
        viewModel.$signingState
            .sink(receiveValue: { receivedSigningState in
                if case .failed = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signIn()
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .failed(.accountNotExists) = viewModel.signingState {
            return
        } else {
            XCTFail("expected signing state is failed - accoutNotExists.")
        }
    }
    
    func test_OnboardingViewModel_signIn_shouldChangeSigningStateToFailed_withErrorDetectedAssociatedValue_whenCorrectAccountWasGiven() {
        // Given
        let expectation = self.expectation()
        viewModel.username = "student"
        viewModel.password = "password"
        
        // When
        viewModel.$signingState
            .sink(receiveValue: { receivedSigningState in
                if case .failed = receivedSigningState {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        viewModel.signIn()
        
        // Then
        wait(for: [expectation], timeout: 3)
        if case .failed(.errorDetected) = viewModel.signingState {
            return
        } else {
            XCTFail("expected signing state is failed - errorDetected.")
        }
    }
}
