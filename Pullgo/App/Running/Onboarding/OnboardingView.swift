//
//  OnboardingView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import SwiftUI
import PullgoKit

struct OnboardingView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    // MARK: - UI
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            
            VStack {
                VStack(spacing: 10) {
                    TextField("아이디를 입력해주세요.", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                    
                    SecureField("비밀번호를 입력해주세요.", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                Button(action: viewModel.signIn) {
                    switch viewModel.signingState {
                        case .valid:
                            Text("로그인")
                        case .signing:
                            ProgressView()
                        default:
                            Text("로그인")
                    }
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: dev.getOnboardingViewModel())
    }
}
