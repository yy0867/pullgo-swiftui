//
//  Running.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import PullgoKit
import SwiftUI

extension PreviewInstance: RunningViewFactory {
    func makeRunningView(authenticationState: Binding<AuthenticationState>) -> RunningView {
        return RunningView(
            authenticationState: authenticationState,
            onboardingView: getOnboardingView()
        )
    }
}
