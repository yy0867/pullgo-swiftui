//
//  LaunchViewModel.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine

public final class LaunchViewModel: ObservableObject {
    
    // MARK: - Properties
    private let userSessionRepository: UserSessionRepositoryProtocol
    @Published public private(set) var appState: AppState = .launching(.starting)
    
    // MARK: - Methods
    public init(userSessionRepository: UserSessionRepositoryProtocol) {
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
}
