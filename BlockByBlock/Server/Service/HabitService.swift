import Foundation

struct HabitService {
    private let repository = HabitRepository()
    
    // fetch habits for a user
    func getHabits(for userId: UUID) async throws -> [HabitModel] {
        try await repository.fetchHabits(userId: userId)
    }
    
    // create a habit using the model
    func createHabit(habit: HabitModel) async throws -> HabitModel {
        return try await repository.createHabit(
            userId: habit.userId,
            title: habit.title
        )
    }
    
    // update habit level using the model
    func updateHabitLevel(habit: HabitModel, newLevel: Int) async throws -> HabitModel {
        return try await repository.updateHabitLevel(
            habitId: habit.id!,
            level: newLevel
        )
    }
    
    // update habit level by one, update the check in time
    func completeDailyHabit(habit: HabitModel) async throws -> HabitModel{
        
        if habit.canCheckIn == false {
            throw NSError(domain: "HabitError", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Habit cannot be checked in at this time."
            ])
        }
        
        let updated_habit = try await repository.updateHabitLevel(habitId: habit.id!, level: habit.level + 1)
        
        return try await repository.updateHabitCheckInTime(habitId: updated_habit.id!)
    }
    
    // delete habit via model
    func deleteHabit(habit: HabitModel) async throws -> HabitModel {
        return try await repository.deleteHabit(habitId: habit.id!)
    }
}
