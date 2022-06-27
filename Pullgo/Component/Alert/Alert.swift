//
//  Alert.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import Foundation
import SwiftUI

struct PresentAlert<Label>: ViewModifier where Label: View {
    @Binding var alertPublisher: AlertPublisher
    private let actions: () -> Label
    
    init(
        _ alertPublisher: Binding<AlertPublisher>,
        @ViewBuilder actions: @escaping () -> Label
    ) {
        self._alertPublisher = alertPublisher
        self.actions = actions
    }
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertPublisher.message ?? "오류가 발생했습니다. 잠시 후 다시 시도해주세요.",
                isPresented: $alertPublisher.isPresented
            ) {
                actions()
            }
    }
}

extension View {
    func onAlert<Label>(
        _ alertPublisher: Binding<AlertPublisher>,
        actions: @escaping () -> Label
    ) -> some View where Label: View {
        modifier(PresentAlert(alertPublisher, actions: actions))
    }
    
    func onAlert(_ alertPublisher: Binding<AlertPublisher>) -> some View {
        modifier(PresentAlert(alertPublisher) {
            Button("확인") {}
        })
    }
}
