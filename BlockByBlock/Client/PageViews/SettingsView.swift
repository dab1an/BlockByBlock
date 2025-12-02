//
//  SettingsView.swift
//  BlockByBlock
//
//  Created by Richard Brito on 12/1/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.custom("Mojangles", size: 32))
                    .padding(.top, 40)
                
                Spacer()
                
                Image("steveface")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                
                Text(authController.profile?.displayName ?? "User")
                    .font(.custom("Mojangles", size: 24))
                    .padding(.top, 20)
                
                Spacer()
                
                Button("Log out") {
                    Task {
                        await authController.signOut()
                    }
                }
                .font(.custom("Mojangles", size: 20))
                .frame(maxWidth: 200)
                .padding()
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.black)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
