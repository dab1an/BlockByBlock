import SwiftUI

struct CheckInButton: View {
    @Binding var currentHabit: HabitModel
    let habitController: HabitController
    let blockController: BlockController
    
    var body: some View {
        Button(action: { Task { await checkInHabit() } }) {
            ZStack {
                Image("Button 1").resizable().aspectRatio(contentMode: .fit).frame(height: 44).frame(maxWidth: .infinity)
                Text("CHECK IN").font(.custom("Mojangles", size: 20)).foregroundColor(.white).shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }
    
    private func checkInHabit() async {
        if let updated = await habitController.completeDailyHabit(habit: currentHabit) {
            withAnimation {
                currentHabit = updated
            }
            Task { await blockController.loadBlocksForHabit(currentHabit) }
        } else {
            print("Failed to complete check-in for habit \(currentHabit.id?.uuidString ?? "")")
        }
    }

}
