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
                // Navigate to LaunchView
                return AnyView(Text("present launch view"))
            case .running(let authenticationState):
                // Navigate to RunningView
                return AnyView(Text("running app"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(dev.getLaunchViewModel())
    }
}
