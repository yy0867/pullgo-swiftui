//
//  Running.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import PullgoKit
import SwiftUI

extension PreviewInstance {
    func getRunningView(_ authenticationState: AuthenticationState) -> RunningView {
        return RunningView(
            authenticationState: authenticationState,
            onboardingViewFactory: getOnboardingView
        )
    }
}
