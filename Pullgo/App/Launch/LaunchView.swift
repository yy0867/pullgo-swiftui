//
//  LaunchView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/20.
//

import SwiftUI
import PullgoKit

struct LaunchView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: LaunchViewModel
    private let runningViewFactory: RunningViewFactory
    
    init(viewModel: LaunchViewModel, runningViewFactory: RunningViewFactory) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.runningViewFactory = runningViewFactory
    }
    
    // MARK: - UI
    var body: some View {        
        contentView()
    }
    
    func contentView() -> AnyView {
        switch viewModel.appState {
            case .launching:
                return AnyView(Text("present launch screen"))
            case .running(let authenticationState):
                return AnyView(
                    runningViewFactory.makeRunningView(
                        authenticationState: .constant(authenticationState)
                    )
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(
            viewModel: dev.getLaunchViewModel(),
            runningViewFactory: dev
        )
    }
}
