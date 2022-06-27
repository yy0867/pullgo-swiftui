//
//  Launch.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import PullgoKit

extension PreviewInstance {
    func getPullgo() -> Pullgo {
        let userSessionDataStore = UserSessionDataStore()
        let userSessionRepository = UserSessionRepository(dataStore: userSessionDataStore)
        
        return Pullgo(userSessionRepository: userSessionRepository)
    }
    
    func getRootView() -> RootView {
        return RootView(
            launchView: getLaunchView(),
            runningViewFactory: getRunningView
        )
    }

    func getLaunchView() -> LaunchView {
        return LaunchView()
    }
}
