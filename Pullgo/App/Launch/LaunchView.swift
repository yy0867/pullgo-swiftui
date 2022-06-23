//
//  LaunchView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/20.
//

import SwiftUI
import PullgoKit

struct LaunchView: View {
    
    @EnvironmentObject private var viewModel: LaunchViewModel
    
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
        LaunchView()
            .environmentObject(dev.getLaunchViewModel())
    }
}
