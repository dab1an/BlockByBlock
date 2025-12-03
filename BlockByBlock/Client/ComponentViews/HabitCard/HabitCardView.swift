import SwiftUI

struct HabitCardView: View {
    let habit: HabitModel
    let habitController: HabitController
    @StateObject private var blockController = BlockController()
    @State private var currentHabit: HabitModel
    
    init(habit: HabitModel, habitController: HabitController) {
        self.habit = habit
        self.habitController = habitController
        _currentHabit = State(initialValue: habit)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HabitHeaderView(currentHabit: $currentHabit, habitController: habitController)
            BlockCarouselView(currentHabit: $currentHabit, blockController: blockController)
            if !currentHabit.canCheckIn {
                XPBarView(
                    level: currentHabit.level,
                    progress: currentHabit.progressPercent
                    )
            }
            if currentHabit.canCheckIn {
                CheckInButton(currentHabit: $currentHabit, habitController: habitController, blockController: blockController)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 40)
        .padding(.bottom, 20)
        .background(Image("HabitCard").resizable())
        .task { await blockController.loadBlocksForHabit(currentHabit) }
        .onChange(of: currentHabit.level) { _ in
            Task { await blockController.loadBlocksForHabit(currentHabit) }
        }
    }
}
