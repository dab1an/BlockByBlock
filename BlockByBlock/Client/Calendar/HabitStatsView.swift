import SwiftUI

struct HabitStatsView: View {
    let selectedDate: Date
    let habits: [HabitModel]
    
    var overallRate: Int { 25 }
    var streak: Int { 1 }
    var habitsDone: Int { 0 }
    
    var body: some View {
        VStack(spacing: 24) {
            // Completion circle with percent
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                Circle()
                    .trim(from: 0, to: CGFloat(overallRate) / 100)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(overallRate)%\nOverall Rate")
                    .multilineTextAlignment(.center)
                    .font(.custom("Mojang-Regular", size: 28))
            }
            .frame(width: 180, height: 180)

            HStack {
                VStack {
                    Text("\(streak)")
                        .font(.custom("Mojang-Regular", size: 24))
                    Text("Streak")
                        .font(.custom("Mojang-Regular", size: 18))
                }
                Spacer()
                VStack {
                    Text("\(habitsDone)")
                        .font(.custom("Mojang-Regular", size: 24))
                    Text("Habits Done")
                        .font(.custom("Mojang-Regular", size: 18))
                }
            }
            .padding(.horizontal, 36)

            VStack(alignment: .leading, spacing: 8) {
                Text("Done Today")
                    .font(.custom("Mojang-Regular", size: 18))
                ForEach(habits) { habit in
                    HStack {
                        Image(systemName: "checkmark.square")
                            .foregroundColor(.green)
                        Text(habit.title)
                            .font(.custom("Mojang-Regular", size: 18))
                        Spacer()
                    }
                    .padding(6)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 12)
            .background(Color(UIColor.systemGray5).opacity(0.5))
            .cornerRadius(10)
        }
        .padding(.top)
    }
}
