//
//  LaunchViewModel.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import PullgoKit

extension PreviewInstance {
    func getLaunchViewModel() -> LaunchViewModel {
        let userSessionDataStore = UserSessionDataStore()
        let userSessionRepository = UserSessionRepository(dataStore: userSessionDataStore)
        
        return LaunchViewModel(userSessionRepository: userSessionRepository)
    }
}
