//
//  URLRequest+.swift
//  NetworkKit
//
//  Created by 김세영 on 2022/06/20.
//

import Foundation

public extension URLRequest {
    
    mutating func buildHeader(
        bearerToken token: String? = nil,
        contentType: ContentType = .json
    ) {
        // add token if not nil
        if let token = token {
            self.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // add content type
        let contentTypeHeader = contentType.asHeader()
        self.addValue(
            contentTypeHeader.value,
            forHTTPHeaderField: contentTypeHeader.field
        )
    }
}

public enum ContentType {
    case json
    case multipart(boundary: String)
    
    func asHeader() -> (field: String, value: String) {
        switch self {
            case .json:
                return ("Content-Type", "application/json")
            case .multipart(let boundary):
                return ("Content-Type", "multipart/form-data; boundary: \(boundary)")
        }
    }
}
