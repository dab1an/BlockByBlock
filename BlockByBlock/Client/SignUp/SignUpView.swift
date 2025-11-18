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
        VStack(spacing: 40) {
            Spacer()

            Text("Block by Block")
                .font(.custom("Mojangles", size: 28))
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.system(size: 18, weight: .medium))
                    TextField("FirstName LastName", text: $fullName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.system(size: 18, weight: .medium))
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.system(size: 18, weight: .medium))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Confirm Password")
                        .font(.system(size: 18, weight: .medium))
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
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
                            .padding()
                    } else {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color(.systemGray4))
                .foregroundColor(.black)
                .cornerRadius(12)
                .disabled(isLoading)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            .padding(.horizontal, 24)

            Spacer()
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthController())
}
