import Foundation
import Combine
import Supabase

@MainActor
class AuthController: ObservableObject {
    
    @Published var session: Session?
    @Published var profile: UserModel?

    private let service = AuthService()

    init() {
        Task {
            await loadInitialSession()
        }
    }

    func loadInitialSession() async {
        do {
            let current = try await service.getSession()
            self.session = current

            if let session = current {
                let userId = session.user.id
                self.profile = try await service.getUserProfile(userId: userId)
            }

        } catch {
            print("Error loading session:", error)
        }
    }

    func signUp(email: String, password: String, displayName: String) async {
        do {
            let session = try await service.signUp(email: email, password: password)
            self.session = session

            let userId = session.user.id

            let profile = try await service.createUserProfile(
                userId: userId,
                displayName: displayName
            )
            self.profile = profile

        } catch {
            print("Signup error:", error)
        }
    }

    func signIn(email: String, password: String) async {
        do {
            let session = try await service.signIn(email: email, password: password)
            self.session = session

            let userId = session.user.id
            self.profile = try await service.getUserProfile(userId: userId)

        } catch {
            print("Signin error:", error)
        }
    }

    func signOut() async {
        do {
            try await service.signOut()
            self.session = nil
            self.profile = nil
        } catch {
            print("Sign out error:", error)
        }
    }
}
