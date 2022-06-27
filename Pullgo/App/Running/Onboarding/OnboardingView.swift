//
//  OnboardingView.swift
//  Pullgo
//
//  Created by 김세영 on 2022/06/24.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var pullgo: Pullgo
    @StateObject private var validator = Validator()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    // MARK: - UI
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    TextField("아이디를 입력해주세요.", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: username) { newValue in
                            validator.username = newValue
                        }
                    
                    SecureField("비밀번호를 입력해주세요.", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: password) { newValue in
                            validator.password = newValue
                        }
                }

                Button(action: signIn) {
                    Text("로그인")
                        .capsuleBackground()
                }
                .disabled(!validator.isValid)
            }
            .padding()
            
            Spacer()
            
            Button("회원가입", action: {})
        }
        .padding(.vertical, 30)
        .onAlert($pullgo.alert)
    }
    
    // MARK: - Methods
    private func signIn() {
        pullgo.signIn(username: username, password: password)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(dev.getPullgo())
            .previewInterfaceOrientation(.portrait)
    }
}
