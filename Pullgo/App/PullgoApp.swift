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
    
    let container = DependencyConatiner()
    
    var body: some Scene {
        WindowGroup {
            container.makeLaunchView()
        }
    }
}
