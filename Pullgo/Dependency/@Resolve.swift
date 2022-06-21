//
//  @Resolve.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation

@propertyWrapper
class Resolve<T> {
    
    var wrappedValue: T
    
    init() {
        wrappedValue = RootDependencyContainer.shared.resolve()
    }
}
