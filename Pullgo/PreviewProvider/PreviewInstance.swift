//
//  PreviewInstance.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import SwiftUI
import PullgoKit

extension PreviewProvider {
    static var dev: PreviewInstance {
        return .shared
    }
}

struct PreviewInstance {
    
    static let shared = PreviewInstance()
    private init() {}
    
    // MARK: - Properties
    let studentUserSession = UserSession.stub(
        token: "token",
        student: Student.stub(
            id: 1,
            account: Account.stub()
        )
    )
    
    let teacherUserSession = UserSession.stub(
        token: "token",
        teacher: Teacher.stub(
            id: 1,
            account: Account.stub()
        )
    )
}
