import Foundation
import Combine

@MainActor
class BlockController: ObservableObject {
    
    private let service = BlockService()
    
    @Published var allBlocks: [BlockModel] = []
    @Published var unlockedBlocks: [BlockModel] = []
    @Published var mysteryBlock: BlockModel?
    
    func loadAllBlocks() async {
        do {
            allBlocks = try await service.getAllBlocks()
        } catch {
            print("Error fetching all blocks:", error)
        }
    }
    
    func loadBlocksForHabit(_ habit: HabitModel) async {
        do {
            let response = try await service.getBlocksForHabit(habit)
            unlockedBlocks = response.unlockedBlocks
            mysteryBlock = response.mysteryBlock
        } catch {
            print("Error fetching blocks for habit level:", error)
        }
    }
}
