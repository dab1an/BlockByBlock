import Foundation

struct BlockService {
    private let repository = BlockRepository()
    
    // fetch all blocks
    func getAllBlocks() async throws -> [BlockModel] {
        try await repository.fetchAllBlocks()
    }
    
    // fetch blocks response with unlocked blocks and mystery block for a habit
    func getBlocksForHabit(_ habit: HabitModel) async throws -> HabitBlocksResponse {
        async let unlockedBlocks = repository.fetchUnlockedBlocks(upToLevel: habit.level)
        async let mysteryBlock = repository.fetchMysteryBlock()
        
        return try await HabitBlocksResponse(
            unlockedBlocks: unlockedBlocks,
            mysteryBlock: mysteryBlock
        )
    }
}
