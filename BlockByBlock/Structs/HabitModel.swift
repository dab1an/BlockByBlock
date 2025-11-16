import Foundation

struct HabitModel: Codable, Identifiable {
    let id: UUID?
    let userId: UUID
    let title: String
    let level: Int
    let createdAt: Date?
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case level
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
