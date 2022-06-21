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
        }
    }
}

extension PullgoApp {
    func configureDependencies() {
        registerLaunchDependencies()
    }
    
    func registerLaunchDependencies() {
        registerUserSessionDataStore()
        registerUserSessionRepository()
    }
    
    func registerUserSessionDataStore() {
        RootDependencyContainer.shared.register(type: UserSessionDataStoreProtocol.self) { _ in
            return UserSessionDataStore()
        }
    }
    
    func registerUserSessionRepository() {
        RootDependencyContainer.shared.register(type: UserSessionRepositoryProtocol.self) { r in
            return UserSessionRepository(dataStore: r.resolve())
        }
    }
}
