import Foundation
import Supabase

struct AuthRepository {
    private let client = SupabaseManager.shared.client

    func signUp(email: String, password: String) async throws -> Session {
        let response = try await client.auth.signUp(
            email: email,
            password: password
        )
        // if active session can not be established, throw
        guard let session = response.session else {
            throw NSError(domain: "AuthError", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "No session returned from signup."
            ])
        }
        return session
    }

    func signIn(email: String, password: String) async throws -> Session {
        let session = try await client.auth.signIn(
            email: email,
            password: password
        )
        return session
    }

    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getSession() async throws -> Session? {
        try await client.auth.session
    }
}
