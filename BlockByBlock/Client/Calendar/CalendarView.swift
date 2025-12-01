import SwiftUI
import UIKit

struct CalendarView: View {
    @State private var selectedDate: Date = Date()
    @EnvironmentObject var habitController: HabitController
    
    var filteredHabits: [HabitModel] {
        habitController.habits
    }
    
    var body: some View {
        VStack {
            Text("Overall")
                .font(.custom("Mojang-Regular", size: 36))
                .padding(.top, 32)
            UIKitCalendar(selectedDate: $selectedDate)
                .frame(height: 350)
                .padding()
            HabitStatsView(selectedDate: selectedDate, habits: filteredHabits)
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
