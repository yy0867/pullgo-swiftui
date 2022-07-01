//
//  SignUpViewModel.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine

public final class SignUpViewModel: ObservableObject, AlertPublishable {
    
    // MARK: - Common Properties
    @Published public var alert: AlertPublisher = (false, nil)
    @Published public var isStudent: Bool = true
    
    private var cancellable: AnyCancellable?
    private let signUpRepository: SignUpRepositoryProtocol
    
    public init(signUpRepository: SignUpRepositoryProtocol) {
        self.signUpRepository = signUpRepository
    }
    
    // MARK: - Common Methods
    public enum SignUpState {
        case none
        case signingUp
        case signedUp
        case failed
    }
    
    @Published public private(set) var signUpState: SignUpState = .none
    
    public func signUp() {
        if isStudent {
            signUpForStudent()
        } else {
            signUpForTeacher()
        }
    }
    
    // MARK: - Phone Verification
    public enum PhoneVerificationState {
        case none
        case requesting
        case requested(number: String)
        case verificated
    }
    
    @Published public var phone: String = ""
    @Published public var fullName: String = ""
    @Published public private(set) var verificationState: PhoneVerificationState = .none
    
    public func requestVerificationNumber() {
        verificationState = .requesting
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.verificationState = .requested(number: "1111")
        }
    }
    
    public func initializeVerification() {
        verificationState = .none
    }
    
    // MARK: - Credential
    public enum UsernameExistState {
        case none
        case searching
        case exists
        case notExists
    }
    
    @Published public var username: String = ""
    @Published public var password: String = ""
    @Published public private(set) var usernameExistState: UsernameExistState = .none
    
    public func isUsernameExists() {
        guard !username.isEmpty else {
            usernameExistState = .none
            return
        }
        
        usernameExistState = .searching
        cancellable = signUpRepository.isTeacherExists(username: username)
            .sink(
                receiveCompletion: isUsernameExistsReceiveCompletion,
                receiveValue: { [weak self] receivedExist in
                    self?.usernameExistState = receivedExist ? .exists : .notExists
                }
            )
    }
    
    private func isUsernameExistsReceiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure:
                sendAlert()
            case .finished:
                break
        }
        cancellable?.cancel()
        usernameExistState = .none
    }
    
    // MARK: - Student
    @Published public var parentPhone: String = ""
    @Published public var schoolName: String = ""
    @Published public var schoolYear: Int = 1
    
    // MARK: - Privates
    private func signUpForStudent() {
        signUpState = .signingUp
        let student = configureStudent()
        cancellable = signUpRepository.signUp(student: student)
            .sink(
                receiveCompletion: receiveCompletion,
                receiveValue: { [weak self] _ in
                    self?.signUpState = .signedUp
                }
            )
    }
    
    private func signUpForTeacher() {
        signUpState = .signingUp
        let teacher = configureTeacher()
        cancellable = signUpRepository.signUp(teacher: teacher)
            .sink(
                receiveCompletion: receiveCompletion,
                receiveValue: { [weak self] _ in
                    self?.signUpState = .signedUp
                }
            )
    }
    
    private func configureStudent() -> Student {
        let account = configureAccount()
        let student = Student(
            account: account,
            parentPhone: parentPhone,
            schoolName: schoolName,
            schoolYear: schoolYear
        )
        
        return student
    }
    
    private func configureTeacher() -> Teacher {
        let account = configureAccount()
        let teacher = Teacher(account: account)
        
        return teacher
    }
    
    private func configureAccount() -> Account {
        return Account(
            username: username,
            fullName: fullName,
            phone: phone,
            password: password
        )
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                signUpState = .none
            case .failure:
                signUpState = .failed
                sendAlert(completion)
        }
        cancellable?.cancel()
    }
}
