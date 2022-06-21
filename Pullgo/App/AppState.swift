//
//  AppState.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
import PullgoKit

enum AppState {
    case launching(LaunchState)
    case running(AuthenticationState)
}

enum LaunchState {
    case starting
    case loadUserSession(AnyCancellable)
}

enum AuthenticationState {
    case authenticated(UserSession)
    case notAuthenticated
}
