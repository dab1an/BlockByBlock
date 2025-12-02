//
//  HomeView.swift
//  BlockByBlock
//
//  Created by Richard Brito on 12/1/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \(authController.profile?.displayName ?? "User")")
                    .font(.custom("Mojangles", size: 28))
                    .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
