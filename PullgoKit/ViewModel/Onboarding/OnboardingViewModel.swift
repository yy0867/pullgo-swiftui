//
//  OnboardingViewModel.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/23.
//

import Foundation
import Combine

public final class OnboardingViewModel: ObservableObject {
    
    enum SigningState {
        case invalid
        case valid
        case signing
        case completed(UserSession)
        case failed(FailedReason)
    }
    
    enum FailedReason {
        case accountNotExists
        case errorDetected
    }
    
    // MARK: - Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published private(set) var signingState: SigningState = .invalid
    
    private let userSessionRepository: UserSessionRepositoryProtocol
    private weak var userSessionDelegate: UserSessionDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    public init(
        userSessionRepository: UserSessionRepositoryProtocol,
        userSessionDelegate: UserSessionDelegate
    ) {
        self.userSessionRepository = userSessionRepository
        self.userSessionDelegate = userSessionDelegate
        
        observeCredentialForValidate()
    }
    
    public func signIn() {
        guard case .valid = signingState else {
            Log.print("SigningState must set to valid.")
            return
        }
        
        let credential = Credential(username: username, password: password)
        let _ = userSessionRepository.signIn(credential: credential)
            .sink(receiveCompletion: signInCompletion, receiveValue: signInSuccess)
    }
    
    // MARK: - Privates
    private func observeCredentialForValidate() {
        $username.combineLatest($password)
            .map(mapCredentialValidateState)
            .assign(to: &$signingState)
    }
    
    private func mapCredentialValidateState(_ username: String, _ password: String) -> SigningState {
        return (!username.isEmpty && !password.isEmpty) ? .valid : .invalid
    }
    
    private func signInCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
                if case PullgoError.signInFail = error {
                    signingState = .failed(.accountNotExists)
                } else {
                    signingState = .failed(.errorDetected)
                }
            case .finished:
                break
        }
    }
    
    private func signInSuccess(_ userSession: UserSession) {
        signingState = .completed(userSession)
        userSessionDelegate?.signedIn(by: userSession)
    }
}
