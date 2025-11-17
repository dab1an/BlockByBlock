import Foundation
import Supabase

struct UserRepository {
    private let client = SupabaseManager.shared.client

    func createProfile(userId: UUID, displayName: String) async throws -> UserModel {
        return try await client
            .from("users")
            .insert([
                "id": userId.uuidString,
                "display_name": displayName
            ])
            .select()
            .single()
            .execute()
            .value
    }

    func fetchProfile(userId: UUID) async throws -> UserModel {
        return try await client
            .from("users")
            .select()
            .eq("id", value: userId.uuidString)
            .single()
            .execute()
            .value
    }
}
