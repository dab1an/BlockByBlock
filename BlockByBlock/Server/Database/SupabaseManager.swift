import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Secrets.supabaseUrl)!,
            supabaseKey: Secrets.supabaseAnonKey
        )
    }
}
