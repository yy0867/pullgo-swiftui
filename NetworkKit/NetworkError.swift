//
//  NetworkError.swift
//  NetworkKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation

public enum NetworkError: Error {
    case invalidCode(code: Int)
    case invalidResponse
}
