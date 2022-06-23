//
//  AppState.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine

public enum AppState {
    case launching(LaunchState)
    case running(AuthenticationState)
}

public enum LaunchState {
    case starting
    case loadUserSession(AnyCancellable)
}

public enum AuthenticationState {
    case authenticated(UserSession)
    case notAuthenticated
}
