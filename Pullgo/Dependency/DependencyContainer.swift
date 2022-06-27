//
//  DependencyContainer.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import PullgoKit
import SwiftUI

final class DependencyConatiner {
    
    typealias RunningViewFactory = (AuthenticationState) -> RunningView
    
    // MARK: - Long Lived
    let userSessionRepository: UserSessionRepositoryProtocol
    @ObservedObject var pullgo: Pullgo
    
    init() {
        // User Session
        func makeUserSessionRepository() -> UserSessionRepositoryProtocol {
            let dataStore = makeUserSessionDataStore()
            return UserSessionRepository(dataStore: dataStore)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStoreProtocol {
            return UserSessionDataStore()
        }
        
        self.userSessionRepository = makeUserSessionRepository()
        self._pullgo = .init(wrappedValue: Pullgo(
            userSessionRepository: self.userSessionRepository
        ))
    }
    
    // MARK: - Factories
    func makeRootView() -> RootView {
        let launchView = makeLaunchView()
        return RootView(
            launchView: launchView,
            runningViewFactory: makeRunningView
        )
    }
    
    func makeLaunchView() -> LaunchView {
        return LaunchView()
    }
    
    func makeRunningView(_ authenticationState: AuthenticationState) -> RunningView {
        return RunningView(
            authenticationState: authenticationState,
            onboardingViewFactory: makeOnboardingView
        )
    }
    
    func makeOnboardingView() -> OnboardingView {
        return OnboardingView()
    }
}
