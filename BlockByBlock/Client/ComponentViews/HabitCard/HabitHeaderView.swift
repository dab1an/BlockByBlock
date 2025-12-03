import SwiftUI

struct HabitHeaderView: View {
    @Binding var currentHabit: HabitModel
    
    var body: some View {
        HStack {
            Text(currentHabit.title)
                .font(.custom("Mojangles", size: 24))
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            if !currentHabit.canCheckIn {
                Button(action: {}) {
                    ZStack {
                        Image("Button").resizable().aspectRatio(contentMode: .fit).frame(height: 20)
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
