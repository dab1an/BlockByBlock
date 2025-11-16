import Foundation
import Supabase

struct HabitRepository {
    private let client = SupabaseManager.shared.client
    
    // returns a list of the users habits from the habit table
    func fetchHabits(userId: UUID) async throws -> [HabitModel] {
        return try await client
            .from("habit")
            .select()
            .eq("user_id", value: userId.uuidString)
            .execute()
            .value
    }
    
    //creates new row in the habit table, returns created row as a model
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
    
    // updates the level of a row in the habit table, returns updated row as model
    func updateHabitLevel(habitId: UUID, level: Int) async throws -> HabitModel {
        return try await client
            .from("habit")
            .update(["level" : level])
            .eq("id", value: habitId)
            .select()
            .single() // ensures we get a single object, not an array
            .execute()
            .value
    }
    
    // updates the last time the habit was checked in by the user
    func updateHabitCheckInTime(habitId: UUID) async throws -> HabitModel{
        let now = Date() // current time (UTC)
                
        return try await client
            .from("habit")
            .update(["updated_at": now])
            .eq("id", value: habitId)
            .select()
            .single() // ensures we get a single object, not an array
            .execute()
            .value
    }
    
    // deletes row from habit table, returns deleted row as model
    func deleteHabit(habitId: UUID) async throws -> HabitModel {
        return try await client
            .from("habit")
            .delete()
            .eq("id", value: habitId)
            .select()
            .single()
            .execute()
            .value
    }
}
