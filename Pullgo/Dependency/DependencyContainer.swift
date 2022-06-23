//
//  DependencyContainer.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation

protocol DependencyContainer {
    var dependencies: [String: Any] { get set }
    
    func register<T>(type: T.Type, _ dependency: (Self) -> T)
    func resolve<T>() -> T
}

extension DependencyContainer {
    func getKey<T>(of dependencyType: T.Type) -> String {
        return String(describing: dependencyType.self)
    }
}
