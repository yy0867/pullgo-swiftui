//
//  PullgoTests.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/23.
//

import XCTest
import Combine
@testable import Pullgo

/// `SucceedPullgoTests` - Succeed Cases
///
/// `loadUserSession()`
///   - 토큰 load 성공하여 `UserSession` 로드까지 성공하면
///   `AppState`가 `.authenticated(UserSession)`이 되는지 확인
class SucceedPullgoTests: XCTestCase {
    
    var viewModel: Pullgo!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        self.viewModel = Pullgo(
            userSessionRepository: TestInstance.shared.succeedUserSessionRepository
        )
    }
    
    override func tearDown() {
        super.tearDown()
        self.viewModel = nil
        self.cancellables.removeAll()
    }
    
    func test_Pullgo_loadUserSessionOfStudent_shouldSetAppStateToAuthenticated_withStudentUserSessionAssociatedValue() {
        // Given
        let expectation = self.expectation()
        
        // When
        var appState: AppState?
        viewModel.$appState
            .sink(
                receiveValue: { receivedAppState in
                    appState = receivedAppState
                    if case .running(.authenticated) = receivedAppState {
                        expectation.fulfill()
                    }
                }
            )
            .store(in: &cancellables)
        
        viewModel.loadUserSession()
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(appState)
        switch appState! {
            case .running(let authenticationState):
                if case .authenticated(let userSession) = authenticationState {
                    XCTAssertNotNil(userSession.student)
                } else {
                    XCTFail("expecting app state is running - authenticated.")
                }
            case .launching:
                XCTFail("expecting app state is running - authenticated.")
        }
    }
}

/// `FailPullgoTests` - Fail Cases
///
/// `loadUserSession()`
///   - 토큰 load 실패, 혹은 토큰은 load했지만 `UserSession`을 로드하는 데에 실패하면
///   `AppState`가 `.notAuthenticated`이 되는지 확인
 class FailPullgoTests: XCTestCase {
     
     var viewModel: Pullgo!
     var cancellables = Set<AnyCancellable>()
     
     override func setUp() {
         super.setUp()
         self.viewModel = Pullgo(
            userSessionRepository: TestInstance.shared.failUserSessionRepository
         )
     }
     
     override func tearDown() {
         super.tearDown()
         self.viewModel = nil
         self.cancellables.removeAll()
     }
    
     func test_Pullgo_loadUserSession_shouldSetAppStateLaunching() {
         // Given
         let expectation = self.expectation()
         
         // When
         var appState: AppState?
         viewModel.$appState
             .sink(
                receiveValue: { receivedAppState in
                    appState = receivedAppState
                    if case .running(.notAuthenticated) = receivedAppState {
                        expectation.fulfill()
                    }
                }
             )
             .store(in: &cancellables)
         
         viewModel.loadUserSession()
         
         // Then
         wait(for: [expectation], timeout: 3)
         XCTAssertNotNil(appState)
         switch appState! {
             case .running(let authenticationState):
                 if case .notAuthenticated = authenticationState {
                     return
                 } else {
                     XCTFail("expecting app state is running - notAuthenticated.")
                 }
             case .launching:
                 XCTFail("expecting app state is running - notAuthenticated.")
         }
     }
}
