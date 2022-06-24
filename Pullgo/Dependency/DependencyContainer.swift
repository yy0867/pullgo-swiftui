//
//  DependencyContainer.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import PullgoKit
import SwiftUI

final class DependencyConatiner {
    
    // MARK: - Long Lived
    let userSessionRepository: UserSessionRepositoryProtocol
    
    init() {
        // User Session
        func makeUserSessionRepository() -> UserSessionRepositoryProtocol {
            let dataStore = makeUserSessionDataStore()
            return UserSessionRepository(dataStore: dataStore)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStoreProtocol {
            return UserSessionDataStore()
        }
        
        self.userSessionRepository = makeUserSessionRepository()
    }
    
    // MARK: - Factories
    func makeLaunchView() -> some View {
        let viewModel = makeLaunchViewModel()
        return LaunchView(viewModel: viewModel)
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(userSessionRepository: userSessionRepository)
    }
}
