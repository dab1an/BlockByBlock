import Foundation
import Combine

@MainActor
class HabitController: ObservableObject {
    
    private let service = HabitService()
    
    @Published var habits: [HabitModel] = []
    
    func loadHabits(userId: UUID) async {
        do {
            habits = try await service.getHabits(userId: userId)
        } catch {
            print("Error fetching habits:", error)
        }
    }
    
    func addHabit(userId: UUID, title: String) async {
        do {
            let habit = try await service.createHabit(userId: userId, title: title)
            habits.append(habit)
        } catch {
            print("Error creating habit:", error)
        }
    }
}
