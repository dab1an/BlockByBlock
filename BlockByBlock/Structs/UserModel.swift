import Foundation

struct UserModel: Codable, Identifiable {
    let id: UUID
    let displayName: String
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case createdAt = "created_at"
    }
}
