//
//  ContentView.swift
//  BlockByBlock
//
//  Created by Dabian  on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    // intialize auth controller
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        Group {
            if authController.session != nil {
                MainAppView()
            } else {
                LoginView()
            }
        }
    }
}


struct MainAppView: View {
    @EnvironmentObject var authController: AuthController
    //boiler plate landing page
    var body: some View {
        VStack {
            Text("Welcome, \(authController.profile?.displayName ?? "User")!")
                .font(.largeTitle)
            
            Button("Sign Out") {
                Task {
                    await authController.signOut()
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthController())
}
