//
//  TestExtension.swift
//  PullgoKitTests
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation
import Combine
import XCTest

extension XCTestCase {
    
    func expectation(_ description: String = #function) -> XCTestExpectation {
        return self.expectation(description: description)
    }
    
    func failWhenReceiveError(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                return
            case .failure(let error):
                XCTFail("Test failed at \(self.name)\nReceived error: \(error)")
        }
    }
    
    func failWhenReceiveValue(_ value: Any) {
        XCTFail("Test failed at \(self.name)\nReceived value: \(value)")
    }
}
