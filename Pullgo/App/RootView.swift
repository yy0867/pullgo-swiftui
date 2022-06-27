//
//  RootView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import SwiftUI

struct RootView: View {
    
    // MARK: - Properties
    @EnvironmentObject var pullgo: Pullgo
    
    private let launchView: LaunchView
    private let makeRunningView: (AuthenticationState) -> RunningView
    
    init(
        launchView: LaunchView,
        runningViewFactory: @escaping (AuthenticationState) -> RunningView
    ) {
        self.launchView = launchView
        self.makeRunningView = runningViewFactory
    }
    
    // MARK: - UI
    var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        switch pullgo.appState {
            case .launching:
                return AnyView(launchView)
            case .running(let authenticationState):
                let runningView = makeRunningView(authenticationState)
                return AnyView(runningView)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        dev.getRootView()
    }
}
