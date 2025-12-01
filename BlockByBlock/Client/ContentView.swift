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
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthController())
}
