//
//  Onboarding.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import Foundation
import PullgoKit

extension PreviewInstance {
    func getOnboardingViewModel() -> OnboardingViewModel {
        let userSessionDataStore = UserSessionDataStore()
        let userSessionRepository = UserSessionRepository(dataStore: userSessionDataStore)
        let userSessionDelegate = getLaunchViewModel()
        
        return OnboardingViewModel(
            userSessionRepository: userSessionRepository,
            userSessionDelegate: userSessionDelegate
        )
    }
    
    func getOnboardingView() -> OnboardingView {
        let viewModel = getOnboardingViewModel()
        return OnboardingView(viewModel: viewModel)
    }
}
