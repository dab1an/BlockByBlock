import SwiftUI

struct HabitHeaderView: View {
    @Binding var currentHabit: HabitModel
    @ObservedObject var habitController: HabitController
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        HStack {
            Text(currentHabit.title)
                .font(.custom("Mojangles", size: 24))
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            
            // delete button
            Button(action: {
                showDeleteConfirmation = true
            }) {
                ZStack {
                    Image("Button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                    Image(systemName: "trash")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .alert("Delete Habit", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    Task {
                        await habitController.deleteHabit(habit: currentHabit)
                    }
                }
            } message: {
                Text("Are you sure you want to delete '\(currentHabit.title)'? This action cannot be undone.")
            }
            
            // X button
            if !currentHabit.canCheckIn {
                Button(action: {}) {
                    ZStack {
                        Image("Button")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        Text("X")
                            .font(.custom("Mojangles", size: 14))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
