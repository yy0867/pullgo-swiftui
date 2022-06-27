//
//  Pullgo.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
import PullgoKit

public final class Pullgo: ObservableObject, AlertPublishable {
    
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    private let userSessionRepository: UserSessionRepositoryProtocol
    @Published private(set) var appState: AppState = .launching(.starting)
    @Published var alert: AlertPublisher = (false, nil)
    
    // MARK: - Methods
    init(userSessionRepository: UserSessionRepositoryProtocol) {
        self.userSessionRepository = userSessionRepository
        
        loadUserSession()
    }
    
    func loadUserSession() {
        let cancellable = userSessionRepository.rememberMe()
            .sink(receiveValue: { [weak self] userSession in
                switch userSession {
                    case .none:
                        self?.appState = .running(.notAuthenticated)
                    case .some(let userSession):
                        self?.appState = .running(.authenticated(userSession))
                }
            })
        
        appState = .launching(.loadUserSession(cancellable))
    }
    
    func signIn(username: String, password: String) {
        cancellable = userSessionRepository.signIn(username: username, password: password)
            .sink(
                receiveCompletion: signInCompletion,
                receiveValue: signedIn
            )
    }
    
    // MARK: - Privates
    private func signInCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
                handleSignInError(error)
            case .finished:
                break
        }
    }
    
    private func handleSignInError(_ error: Error) {
        if let error = error as? PullgoError {
            if case .signInFail = error {
                sendAlert("아이디 혹은 비밀번호가 일치하지 않아요.")
            }
        } else {
            sendAlert()
        }
    }
    
    private func signedIn(_ userSession: UserSession) {
        appState = .running(.authenticated(userSession))
    }
}

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
