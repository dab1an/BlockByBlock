import Foundation

struct BlockModel: Codable, Identifiable {
    let blockName: String
    let unlockLevel: Int
    let url: String
    
    var id: String { blockName }
    
    enum CodingKeys: String, CodingKey {
        case blockName = "block_name"
        case unlockLevel = "unlock_level"
        case url
    }
}

// object containing unlocked blocks that should be displayed on a habit card and the mystery block (block showing there is more to be unlocked)
struct HabitBlocksResponse: Codable {
    let unlockedBlocks: [BlockModel]
    let mysteryBlock: BlockModel
    
    enum CodingKeys: String, CodingKey {
        case unlockedBlocks = "unlocked_blocks"
        case mysteryBlock = "mystery_block"
    }
}
