//
//  LaunchViewModel.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
import PullgoKit

final class LaunchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Resolve private var userSessionRepository: UserSessionRepositoryProtocol
    @Published var appState: AppState = .launching(.starting)
    
    // MARK: - Methods
    init() {
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
}
