//
//  Logger.swift
//  NetworkKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation
import OSLog

public final class Log {
    
    private static let logger = Logger()
    
    static func print(_ message: String, level: OSLogType = .default) {
        logger.log(level: level, "\(message)")
    }
}
