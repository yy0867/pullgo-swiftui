//
//  AccentBackground.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import SwiftUI

struct CapsuleBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: geo.size.height / 2)
                        .foregroundColor(.accentColor)
                )
        }
    }
}

extension View {
    func capsuleBackground() -> some View {
        ZStack {
            modifier(CapsuleBackground())
        }
    }
}
