//
//  SignUpViewModel.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine

public final class SignUpViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let userSessionRepository: UserSessionRepositoryProtocol
    
    public init(userSessionRepository: UserSessionRepositoryProtocol) {
        self.userSessionRepository = userSessionRepository
    }
    
    // MARK: - Phone Verification
    
    // MARK: - Credential
    
    // MARK: - Student
}
