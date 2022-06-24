//
//  RunningView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/23.
//

import SwiftUI
import PullgoKit

struct RunningView: View {
    
    // MARK: - Properties
    @Binding var authenticationState: AuthenticationState
    let onboardingView: OnboardingView
    
    init(authenticationState: Binding<AuthenticationState>, onboardingView: OnboardingView) {
        self._authenticationState = authenticationState
        self.onboardingView = onboardingView
    }
    
    // MARK: - UI
    var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        switch authenticationState {
            case .authenticated(let userSession):
                // present view of teacher / student
                return AnyView(Text("present signed in view"))
            case .notAuthenticated:
                return AnyView(onboardingView)
        }
    }
}

protocol RunningViewFactory {
    func makeRunningView(authenticationState: Binding<AuthenticationState>) -> RunningView
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RunningView(
                authenticationState: .constant(.notAuthenticated),
                onboardingView: dev.getOnboardingView()
            )
            
            RunningView(
                authenticationState: .constant(.authenticated(dev.studentUserSession)),
                onboardingView: dev.getOnboardingView()
            )
            
            RunningView(
                authenticationState: .constant(.authenticated(dev.teacherUserSession)),
                onboardingView: dev.getOnboardingView()
            )
        }
    }
}
