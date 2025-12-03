import SwiftUI
internal import Auth

struct CreateHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var habitController: HabitController
    
    @State private var habitTitle: String = ""
    @State private var isCreating: Bool = false
    @State private var errorMessage: String?
    
    private let habitRepository = HabitRepository()
    
    var body: some View {
        ZStack {
            // background
            Image("dirt_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Create New Habit")
                    .font(.custom("Mojangles", size: 32))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    .padding(.top, 40)
                
                // habit title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Habit Name")
                        .font(.custom("Mojangles", size: 18))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                    
                    TextField("Enter habit name", text: $habitTitle)
                        .font(.custom("Mojangles", size: 16))
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        )
                }
                .padding(.horizontal, 24)
                
                
                Spacer()
                
                // create button
                Button(action: {
                    Task {
                        await createHabit()
                    }
                }) {
                    ZStack {
                        Image("Button 2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 25)

                        
                        if isCreating {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Create Habit")
                                .font(.custom("Mojangles", size: 20))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                                .padding(.bottom, 25)
                        }
                    }
                }
                .disabled(habitTitle.isEmpty || isCreating)
                .opacity(habitTitle.isEmpty ? 0.5 : 1.0)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    private func createHabit() async {
        guard let userId = authController.session?.user.id else {
            errorMessage = "User not authenticated"
            return
        }
        
        isCreating = true
        errorMessage = nil
        
        do {
            _ = try await habitRepository.createHabit(
                userId: userId,
                title: habitTitle.trimmingCharacters(in: .whitespaces)
            )
            //refresh habits on the habitlistview as soon as u add it.
            await habitController.loadHabits(userId: userId)

            
            // dismiss view if successful
            dismiss()
        } catch {
            errorMessage = "Failed to create habit: \(error.localizedDescription)"
            isCreating = false
        }
    }
}

#Preview {
    NavigationStack {
        CreateHabitView()
            .environmentObject(AuthController())
            .environmentObject(HabitController())

    }
}
