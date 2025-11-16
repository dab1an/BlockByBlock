import Foundation

struct HabitService {
    private let repository = HabitRepository()
    
    func getHabits(userId: UUID) async throws -> [HabitModel] {
        try await repository.fetchHabits(userId: userId)
    }
    
    func createHabit(userId: UUID, title: String) async throws -> HabitModel {
        try await repository.createHabit(userId: userId, title: title)
    }
}
