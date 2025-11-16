import Foundation
import Combine

@MainActor
class HabitController: ObservableObject {
    
    private let service = HabitService()
    
    @Published var habits: [HabitModel] = []
    
    func loadHabits(userId: UUID) async {
        do {
            habits = try await service.getHabits(for: userId)
        } catch {
            print("Error fetching habits:", error)
        }
    }
    
    func addHabit(userId: UUID, title: String) async {
        do {
            let newHabit = HabitModel(
                id: nil,
                userId: userId,
                title: title,
                level: 1,
                createdAt: nil,
                updatedAt: nil
            )
            
            let created = try await service.createHabit(habit: newHabit)
            habits.append(created)
        } catch {
            print("Error creating habit:", error)
        }
    }
    
    func updateHabitLevel(habit: HabitModel, newLevel: Int) async {
        do {
            
            let saved = try await service.updateHabitLevel(habit : habit, newLevel : newLevel)
            
            if let index = habits.firstIndex(where: { $0.id == saved.id }) {
                habits[index] = saved
            }
        } catch {
            print("Error updating habit:", error)
        }
    }
    
    func completeDailyHabit(habit: HabitModel) async {
        do {
            try await service.completeDailyHabit(habit: habit)
        }
        catch{
            print("Error completing daily habit:", error)
        }
    }
    
    func deleteHabit(habit: HabitModel) async {
        do {
            let deleted = try await service.deleteHabit(habit: habit)
            habits.removeAll { $0.id == deleted.id }
        } catch {
            print("Error deleting habit)", error)
        }
    }
}
