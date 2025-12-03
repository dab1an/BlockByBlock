//
//  CreateHabitButton.swift
//  BlockByBlock
//
//  Created by Richard Brito on 12/2/25.
//

import SwiftUI

struct CreateHabitButton: View {
    
    var body: some View {
        NavigationLink(destination: CreateHabitView()) {
            ZStack {
                Image("Button 2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding(.top, 30)
                
                Text("Create Habit")
                    .font(.custom("Mojangles", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                    .padding(.top, 30)
            }
        }
        .navigationBarBackButtonHidden(true) 
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}
