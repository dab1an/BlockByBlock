import SwiftUI
import Supabase

struct RefreshHabitsButton: View {
    @EnvironmentObject var authController: AuthController
    @ObservedObject var habitController: HabitController
    
    var body: some View {
        Button(action: {
            Task {
                if let userId = authController.session?.user.id {
                    await habitController.loadHabits(userId: userId)
                }
            }
        }) {
            ZStack {
                Image("Button")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .padding(.top, 30)
                
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                    .padding(.top, 30)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
