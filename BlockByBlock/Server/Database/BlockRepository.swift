import Foundation
import Supabase

struct BlockRepository {
    private let client = SupabaseManager.shared.client
    
    // fetches all blocks
    func fetchAllBlocks() async throws -> [BlockModel] {
        return try await client
            .from("block")
            .select()
            .order("unlock_level")
            .execute()
            .value
    }
    
    // fetches blocks up to and including the specified level (excluding mystery block)
    func fetchUnlockedBlocks(upToLevel level: Int) async throws -> [BlockModel] {
        return try await client
            .from("block")
            .select()
            .lte("unlock_level", value: level)
            .neq("unlock_level", value: 999)
            .order("unlock_level")
            .execute()
            .value
    }
    
    // fetches mystery block
    func fetchMysteryBlock() async throws -> BlockModel {
        return try await client
            .from("block")
            .select()
            .eq("unlock_level", value: 999)
            .single()
            .execute()
            .value
    }
}
