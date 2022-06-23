//
//  RunningView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/23.
//

import SwiftUI
import PullgoKit

struct RunningView: View {
    
    let authenticationState: AuthenticationState
    
    var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        switch authenticationState {
            case .authenticated(let userSession):
                // present view of teacher / student
                return AnyView(Text("present signed in view"))
            case .notAuthenticated:
                // present onboarding
                return AnyView(Text("present onboarding"))
        }
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RunningView(authenticationState: .notAuthenticated)
            
            RunningView(authenticationState: .authenticated(dev.studentUserSession))
            
            RunningView(authenticationState: .authenticated(dev.teacherUserSession))
        }
    }
}
