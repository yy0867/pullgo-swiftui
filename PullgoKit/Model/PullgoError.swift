//
//  PullgoError.swift
//  PullgoKit
//
//  Created by 김세영 on 2022/06/16.
//

import Foundation

public enum PullgoError: Error {
    case unknown
    case networkError(error: NetworkError)
    case signInFail
    case idNotFound
}
