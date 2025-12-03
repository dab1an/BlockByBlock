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

extension HabitModel {
    
    // decides whether or not the user can check in their habit 24hr <= x <= 48hr
    var canCheckIn: Bool {
        guard let updatedAt = updatedAt else { return true } // never updated, allow check-in
        let now = Date()
        let timeSinceUpdate = now.timeIntervalSince(updatedAt)
        return timeSinceUpdate >= 24*60*60 && timeSinceUpdate <= 48*60*60
    }

    var progressPercent: Double {
        guard let updatedAt = updatedAt else {
            return 1.0 // if never updated, treat as 100% (can check in)
        }

        let now = Date()
        let elapsed = now.timeIntervalSince(updatedAt)
        let required: TimeInterval = 24*60*60 // 24 hrs as seconds

        // clamp between 0 - 1
        let percent = min(max(elapsed / required, 0), 1)

        return percent
    }
}
