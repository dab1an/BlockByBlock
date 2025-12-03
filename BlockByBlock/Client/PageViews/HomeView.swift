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
            VStack(spacing: 0) {
                // week view with grass background at the top
                WeekView()
                    .ignoresSafeArea(edges: .top)
                
                // main content with dirt background - scrollable
                ScrollView {
                    VStack(spacing: 0) {
                        Text("Welcome, \(authController.profile?.displayName ?? "User")")
                            .font(.custom("Mojangles", size: 28))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        HabitListView()
                    }
                }
                .background(
                    Image("dirt_bg")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}