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
        VStack {
            Text("Welcome, \(authController.profile?.displayName ?? "User")")
                .font(.custom("Mojangles", size: 28))
                .foregroundColor(.white)
                .padding()
                .padding(.top, 40)

            HabitListView()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("dirt_bg")
                .resizable()
                .scaledToFill()
                .padding(.top, -100)
                .padding(.bottom, -100)
                .ignoresSafeArea()
        )
        .ignoresSafeArea()
    }
}
