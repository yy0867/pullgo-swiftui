//
//  RunningView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import SwiftUI

struct RunningView: View {
    
    private let authenticationState: AuthenticationState
    private let makeOnboardingView: () -> OnboardingView
    
    init(
        authenticationState: AuthenticationState,
        onboardingViewFactory: @escaping () -> OnboardingView
    ) {
        self.authenticationState = authenticationState
        self.makeOnboardingView = onboardingViewFactory
    }
    
    var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        switch authenticationState {
            case .authenticated(let userSession):
                return AnyView(Text("Authenticated"))
            case .notAuthenticated:
                let onboardingView = makeOnboardingView()
                return AnyView(onboardingView)
        }
    }
}

struct Running_Previews: PreviewProvider {
    static var previews: some View {
        RunningView(
            authenticationState: .notAuthenticated,
            onboardingViewFactory: dev.getOnboardingView
        )
    }
}
