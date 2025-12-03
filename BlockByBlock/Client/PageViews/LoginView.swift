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
            ZStack {
                Image("SunsetBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    Image("MinecraftLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40) // Adjusted height to fit well
                        .padding(.top, 40)
                    
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("EMAIL:")
                                .font(.custom("Mojangles", size: 18))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 1, x: 2, y: 2)
                            SecureField("", text: $email, prompt: Text("Email").foregroundColor(.gray))
                                .font(.custom("Mojangles", size: 16))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.85))
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("PASSWORD:")
                                .font(.custom("Mojangles", size: 18))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 1, x: 2, y: 2)
                            SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                .font(.custom("Mojangles", size: 16))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.85))
                                .cornerRadius(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
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
                                                .buttonStyle(MinecraftButtonStyle())
                                                .disabled(isLoading)
                                                
                                                // navigate to signup view
                                                NavigationLink(destination: SignUpView()) {
                                                    Text("Sign Up")
                                                        .frame(maxWidth: .infinity)
                                                }
                                                // Applied custom style to use Unclicked/Clicked images
                                                .buttonStyle(MinecraftButtonStyle())
                                            }
                                            .padding()
                                            .padding(.horizontal, 24)
                                            
                                            Spacer()
                }
            }
        }
    }
}
// Created a reusable ButtonStyle to handle the Image Swapping (Unclicked/Clicked) logic
struct MinecraftButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Logic: If pressed, show "Clicked", otherwise show "Unclicked"
            Image(configuration.isPressed ? "Clicked" : "Unclicked")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50) // Adjust height to fit your asset
            
            configuration.label
                .font(.custom("Mojangles", size: 20))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                // Slight offset to make it look like the text moves down with the button press
                .offset(y: configuration.isPressed ? 2 : 0)
        }
    }
}
            
    #Preview {
        LoginView()
            .environmentObject(AuthController())
    }
