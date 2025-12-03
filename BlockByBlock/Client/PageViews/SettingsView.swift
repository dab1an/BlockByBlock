import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.custom("Mojangles", size: 32))
                    .padding(.top, 40)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("steveface")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                
                Text(authController.profile?.displayName ?? "User")
                    .font(.custom("Mojangles", size: 24))
                    .padding(.top, 20)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await authController.signOut()
                    }
                })
                {
                    Text("LOG OUT")
                        .font(.custom("Mojangles", size: 20))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                }
                .buttonStyle(CustomMinecraftButtonStyle(unclickedImage: "Unclicked", clickedImage: "Clicked"))
                .frame(maxWidth: 200)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("nether_bg")
                    .resizable()
                    .scaledToFill()
                    .padding(.top, -100)
                    .padding(.bottom, -100)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
            .padding(.top, 20)
        }
    }
}
struct CustomMinecraftButtonStyle: ButtonStyle {
    let unclickedImage: String
    let clickedImage: String
    let height: CGFloat = 50
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image(configuration.isPressed ? clickedImage : unclickedImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height)
            configuration.label
                .offset(y: configuration.isPressed ? 2 : 0)
        }
    }
}
