//
//  RootDependencyContainer.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import Foundation

final class RootDependencyContainer: DependencyContainer {
    
    static let shared = RootDependencyContainer()
    private init() {}
    
    var dependencies = [String : Any]()
    
    func register<T>(type: T.Type, _ dependency: (RootDependencyContainer) -> T) {
        let key = getKey(of: T.self)
        let instance = dependency(RootDependencyContainer.shared)
        
        dependencies.updateValue(instance, forKey: key)
    }
    
    func resolve<T>() -> T {
        let key = getKey(of: T.self)
        
        guard let dependency = dependencies[key] as? T else {
            fatalError("Fail to get instance of \(key) from dependency container.")
        }
        
        return dependency
    }
    
    func resolve<T>(type: T.Type) -> T {
        return resolve()
    }
}
