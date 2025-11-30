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
    @StateObject var habitController = HabitController()
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(authController.profile?.displayName ?? "User")!")
                    .font(.largeTitle)
                NavigationLink(destination: CalendarView().environmentObject(habitController)) {
                    Text("Open Calendar")
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
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
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthController())
}
