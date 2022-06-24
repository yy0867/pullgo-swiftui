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
    
    init(viewModel: LaunchViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
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
                return AnyView(RunningView(authenticationState: authenticationState))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(viewModel: dev.getLaunchViewModel())
    }
}
