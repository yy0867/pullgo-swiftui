//
//  PullgoApp.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/20.
//

import SwiftUI
import PullgoKit

@main
struct PullgoApp: App {
    
    init() {
        configureDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(RootDependencyContainer.shared.resolve(type: LaunchViewModel.self))
        }
    }
}

extension PullgoApp {
    func configureDependencies() {
        registerLaunchDependencies()
    }
    
    func registerLaunchDependencies() {
        registerLaunchViewModel()
    }
    
    func registerLaunchViewModel() {
        registerUserSessionRepository()
        
        RootDependencyContainer.shared.register(type: LaunchViewModel.self) { r in
            return LaunchViewModel(userSessionRepository: r.resolve())
        }
    }
    
    func registerUserSessionRepository() {
        registerUserSessionDataStore()
        
        RootDependencyContainer.shared.register(type: UserSessionRepositoryProtocol.self) { r in
            return UserSessionRepository(dataStore: r.resolve())
        }
    }
    
    func registerUserSessionDataStore() {
        RootDependencyContainer.shared.register(type: UserSessionDataStoreProtocol.self) { _ in
            return UserSessionDataStore()
        }
    }
}
