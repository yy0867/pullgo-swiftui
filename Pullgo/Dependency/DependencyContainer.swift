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
    
    // MARK: - Long Lived
    let userSessionRepository: UserSessionRepositoryProtocol
    let launchViewModel: LaunchViewModel
    
    init() {
        // User Session
        func makeUserSessionRepository() -> UserSessionRepositoryProtocol {
            let dataStore = makeUserSessionDataStore()
            return UserSessionRepository(dataStore: dataStore)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStoreProtocol {
            return UserSessionDataStore()
        }
        
        // Launch
        func makeLaunchViewModel(
            userSessionRepository: UserSessionRepositoryProtocol
        ) -> LaunchViewModel {
            return LaunchViewModel(userSessionRepository: userSessionRepository)
        }
        
        self.userSessionRepository = makeUserSessionRepository()
        self.launchViewModel = makeLaunchViewModel(userSessionRepository: userSessionRepository)
    }
    
    // MARK: - Factories
    // Launching
    func makeLaunchView() -> some View {
        let viewModel = makeLaunchViewModel()
        return LaunchView(
            viewModel: viewModel,
            runningViewFactory: self
        )
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(userSessionRepository: userSessionRepository)
    }
    
    // Running
    func makeRunningView(authenticationState: Binding<AuthenticationState>) -> RunningView {
        let onboardingView = makeOnboardingView()
        return RunningView(
            authenticationState: authenticationState,
            onboardingView: onboardingView
        )
    }
    
    // Onboarding
    func makeOnboardingView() -> OnboardingView {
        let viewModel = makeOnboardingViewModel()
        return OnboardingView(viewModel: viewModel)
    }
    
    func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel(
            userSessionRepository: userSessionRepository,
            userSessionDelegate: launchViewModel
        )
    }
}

extension DependencyConatiner: RunningViewFactory {}
