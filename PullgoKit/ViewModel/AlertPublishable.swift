//
//  AlertPublishable.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/27.
//

import Foundation
import Combine

public typealias AlertPublisher = (isPresented: Bool, message: String?)

public protocol AlertPublishable: AnyObject {
    var alert: AlertPublisher { get set }
    
    func sendAlert(_ message: String)
}

public extension AlertPublishable {
    func sendAlert(_ message: String = "오류가 발생했습니다. 잠시 후 다시 시도해주세요.") {
        alert = (true, message)
    }
    
    func sendAlert(_ completion: Subscribers.Completion<Error>) {
        self.sendAlert()
    }
}
