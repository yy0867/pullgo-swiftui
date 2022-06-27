//
//  Validator.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import Foundation
import Combine

class Validator: ObservableObject {
    
    // MARK: - Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published private(set) var isValid: Bool = false
    
    // MARK: - Methods
    init() {
        $username
            .combineLatest($password)
            .map { (username, password) -> Bool in
                return !username.isEmpty && !password.isEmpty
            }
            .assign(to: &$isValid)
    }
}
