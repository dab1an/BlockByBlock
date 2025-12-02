import SwiftUI
import Supabase

struct HabitListView: View {
    @EnvironmentObject var authController: AuthController
    @StateObject private var habitController = HabitController()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(habitController.habits.sorted(by: { ($0.createdAt ?? .distantPast) < ($1.createdAt ?? .distantPast) })) { habit in
                    HabitCardView(habit: habit)
                        .padding(.horizontal, 24)
                }
            }
            .padding(.top, 12)
        }
        .task {
            if let userId = authController.session?.user.id {
                await habitController.loadHabits(userId: userId)
            }
        }
    }
}
