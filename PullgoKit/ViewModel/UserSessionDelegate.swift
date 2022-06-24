//
//  UserSessionDelegate.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/23.
//

import Foundation

public protocol UserSessionDelegate: AnyObject {
    func signedIn(by userSession: UserSession)
    func signOut()
}
