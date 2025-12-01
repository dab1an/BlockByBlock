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

                VStack {
                    Text("Welcome, \(authController.profile?.displayName ?? "User")")
                        .font(.custom("Mojangles", size: 28))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                
                // nav bar
                HStack {
                    // calendar
                    NavigationLink(destination: Text("CalendarView")) {
                        Image(systemName: "calendar")
                            .font(.system(size: 28))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // home button
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "house")
                            .font(.system(size: 28))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // settings
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 28))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 20)
                .background(Color(UIColor.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3)),
                    alignment: .top
                )
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
