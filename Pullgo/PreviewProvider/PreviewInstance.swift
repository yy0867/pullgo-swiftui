//
//  PreviewInstance.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/21.
//

import SwiftUI

extension PreviewProvider {
    static var dev: PreviewInstance {
        return .shared
    }
}

struct PreviewInstance {
    
    static let shared = PreviewInstance()
    private init() {}
}
