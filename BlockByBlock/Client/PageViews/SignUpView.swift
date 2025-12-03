import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authController: AuthController
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
                    Image("FallBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 40) {
                        Spacer()
                        Image("MinecraftLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            .padding(.top, 40)

                        VStack(spacing: 32) {
                            
                            // NAME FIELD
                            VStack(alignment: .leading, spacing: 8) {
                                Text("NAME:")
                                    .font(.custom("Mojangles", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 2, y: 2)
                                

                                TextField("", text: $fullName, prompt: Text("First Last").foregroundColor(.gray))
                                    .font(.custom("Mojangles", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.85))
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }

                            // EMAIL FIELD
                            VStack(alignment: .leading, spacing: 8) {
                                Text("EMAIL:")
                                    .font(.custom("Mojangles", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 2, y: 2)
                                
                                TextField("", text: $email, prompt: Text("Email").foregroundColor(.gray))
                                    .font(.custom("Mojangles", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.85))
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            
                            // PASSWORD FIELD
                            VStack(alignment: .leading, spacing: 8) {
                                Text("PASSWORD:")
                                    .font(.custom("Mojangles", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 2, y: 2)
                                
                                SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                    .font(.custom("Mojangles", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.85))
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            
                            // CONFIRM PASSWORD FIELD
                            VStack(alignment: .leading, spacing: 8) {
                                Text("CONFIRM PASSWORD:")
                                    .font(.custom("Mojangles", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 2, y: 2)

                                SecureField("", text: $confirmPassword, prompt: Text("Confirm Password").foregroundColor(.gray))
                                    .font(.custom("Mojangles", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.85))
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.custom("Mojangles", size: 14))
                                    .shadow(color: .black, radius: 1)
                            }
                            
                            // call authcontroller sign up
                            Button(action: {
                                guard password == confirmPassword else {
                                    errorMessage = "Passwords do not match"
                                    return
                                }
                                
                                guard !fullName.isEmpty else {
                                    errorMessage = "Please enter your name"
                                    return
                                }
                                
                                errorMessage = ""
                                
                                Task {
                                    isLoading = true
                                    await authController.signUp(
                                        email: email,
                                        password: password,
                                        displayName: fullName
                                    )
                                    isLoading = false
                                }
                            }) {
                                if isLoading {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("SIGN UP")
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .buttonStyle(MinecraftButtonStyle())
                            .disabled(isLoading)
                        }
                        .padding()
                        .padding(.horizontal, 24)

                        Spacer()
                    }
                }
            }
        }

#Preview {
    SignUpView()
        .environmentObject(AuthController())
}
