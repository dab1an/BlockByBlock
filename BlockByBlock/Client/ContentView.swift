//
//  ContentView.swift
//  BlockByBlock
//
//  Created by Dabian  on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        Group {
            if authController.session != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            TabView(selection: $selectedTab) {
                CalendarView()
                    .tag(0)
                
                HomeView()
                    .tag(1)
                
                SettingsView()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            BottomNavBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomNavBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // Calendar
            Button(action: { selectedTab = 0 }) {
                Image(systemName: "calendar")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == 0 ? .blue : .primary)
                    .frame(maxWidth: .infinity)
            }
            
            // Home
            Button(action: { selectedTab = 1 }) {
                Image(systemName: "house")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == 1 ? .blue : .primary)
                    .frame(maxWidth: .infinity)
            }
            
            // Settings
            Button(action: { selectedTab = 2 }) {
                Image(systemName: "gearshape")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == 2 ? .blue : .primary)
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
}

#Preview {
    ContentView()
        .environmentObject(AuthController())
}
