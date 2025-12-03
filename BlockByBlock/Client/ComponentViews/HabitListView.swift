import SwiftUI
import Supabase

struct HabitListView: View {
    @EnvironmentObject var authController: AuthController
    @StateObject private var habitController = HabitController()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // re add bg, navigation stack always prioritizes white bg. so we need to add it again.
                Image("dirt_bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ScrollView {
                    // conditional render create habit button if habits are empty
                    if habitController.habits.isEmpty {
                        // this is the same as CreateHabitButton but centered
                        NavigationLink(destination: CreateHabitView()) {
                            ZStack {
                                Image("Button 2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                
                                Text("Create Habit")
                                    .font(.custom("Mojangles", size: 20))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .padding(.top, 48)
                    } else {
                        //otherwise we show button on the left. and iterate through habits
                        CreateHabitButton()
                        LazyVStack(spacing: 24) {
                            ForEach(habitController.habits.sorted(by: { ($0.createdAt ?? .distantPast) < ($1.createdAt ?? .distantPast) })) { habit in
                                HabitCardView(habit: habit, habitController: habitController)
                                    .padding(.horizontal, 24)
                            }
                        }
                        .padding(.top, 12)
                    }
                }
            }
        }
        .environmentObject(habitController)
        .task {
            if let userId = authController.session?.user.id {
                await habitController.loadHabits(userId: userId)
            }
        }
    }
}
