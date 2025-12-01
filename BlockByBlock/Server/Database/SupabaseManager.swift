import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://djyozkgtrfshqulsytup.supabase.co")!,
            supabaseKey: "sb_secret_zjrJcs7XKcGhrdoPi6fqOg_NpQ9Lyma"
        )
    }
}
