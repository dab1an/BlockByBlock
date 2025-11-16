import Foundation
import Supabase

struct AuthService {
    private let authRepository = AuthRepository()
    private let userRepository = UserRepository()

    func signUp(email: String, password: String) async throws -> Session {
        try await authRepository.signUp(email: email, password: password)
    }

    func signIn(email: String, password: String) async throws -> Session {
        try await authRepository.signIn(email: email, password: password)
    }

    func signOut() async throws {
        try await authRepository.signOut()
    }

    func getSession() async throws -> Session? {
        try await authRepository.getSession()
    }

    func createUserProfile(userId: UUID, displayName: String) async throws -> UserModel {
        try await userRepository.createProfile(userId: userId, displayName: displayName)
    }

    func getUserProfile(userId: UUID) async throws -> UserModel {
        try await userRepository.fetchProfile(userId: userId)
    }
}
