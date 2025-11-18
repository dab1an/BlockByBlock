//
//  LoginView.swift
//  BlockByBlock
//
//  Created by Richard Brito on 11/16/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authController: AuthController
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                Text("Block by Block")
                    .font(.custom("Mojangles", size: 28))
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 18, weight: .medium))
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 18, weight: .medium))
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    // call authcontroller sign in
                    Button(action: {
                        Task {
                            isLoading = true
                            await authController.signIn(email: email, password: password)
                            isLoading = false
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .background(Color(.darkGray))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(isLoading)
                    // navigate to signup view
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray4))
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthController())
}
