import Foundation
import Supabase

struct HabitRepository {
    private let client = SupabaseManager.shared.client
    
    func fetchHabits(userId: UUID) async throws -> [HabitModel] {
        try await client
            .from("habit")
            .select()
            .eq("user_id", value: userId.uuidString)
            .execute()
            .value
    }
    
    func createHabit(userId: UUID, title: String) async throws -> HabitModel {
        let newHabit = HabitModel(
            id: nil,
            userId: userId,
            title: title,
            level: 1,
            createdAt: nil,
            updatedAt: nil
        )
        
        return try await client
            .from("habit")
            .insert(newHabit)
            .select()
            .single()
            .execute()
            .value
    }
}
