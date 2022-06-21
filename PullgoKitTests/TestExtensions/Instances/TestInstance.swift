//
//  TestInstance.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import PullgoKit

class TestInstance {
    
    static let shared = TestInstance()
    
    // MARK: - UserSession
    var fakeStudent: Student { succeedUserSessionDataStore.fakeStudent }
    var fakeTeacher: Teacher { succeedUserSessionDataStore.fakeTeacher }
    
    let succeedUserSessionDataStore = TestUserSessionDataStore(isSucceedCase: true)
    let failUserSessionDataStore = TestUserSessionDataStore(isSucceedCase: false)
}
