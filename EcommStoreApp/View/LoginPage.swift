//
//  LoginPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI
import KeychainSwift

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @EnvironmentObject private var loginState: LoginState // Use the LoginState object

    @State private var draggedOffset: CGSize = .zero
    @Binding var showLoginPage: Bool
    @State private var navigateToMainPage: Bool = false
    @State private var showErrorAlert: Bool = false

    // Add this variable for dragging offset
    @GestureState private var dragState = CGSize.zero

    // Constants
    private let gradientColors = [
        Color("LC1"),
        Color("LC2").opacity(0.8),
        Color("red")
    ]

    private let primaryButtonTitle = "Delete"
    private let secondaryButtonTitle = "Cancel"

    var body: some View {
        VStack {
            Button {
                showLoginPage = false
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(12)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .contentShape(Rectangle())
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        showLoginPage = false
                    }
            )

            Text(loginData.errorMessage)
                .foregroundColor(.red)
                .padding(.top, 10)

            Text("Welcome\nBack")
                .font(.system(size: 55).lowercaseSmallCaps()).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .padding()
                .background(
                    ZStack {
                        LinearGradient(colors: gradientColors,
                                       startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()

                    Image("Google")  // Replace "Google" with your actual image name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .offset(y: 95)
                        .padding(.trailing, 30)  // Adjust padding as needed
                        .scaleEffect(isPressed ? 0.9 : 1.0)
                        .onTapGesture {
                            isPressed.toggle()
                            print("Google button tapped")
                        }
                        .animation(.easeInOut(duration: 0.1))

                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)

                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity,maxHeight: .infinity ,alignment: .topLeading)
                            .padding(.leading, 30)
                    }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            draggedOffset = value.translation
                        }
                        .onEnded { value in
                            if draggedOffset.width > 100 {
                                showLoginPage = false
                            }
                            draggedOffset = .zero
                        }
                        .simultaneously(with: TapGesture())
                )

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.system(size: 22).lowercaseSmallCaps().bold())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    CustomTextField(icon: "envelope", title: "Email", hint: "rumenguin@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)

                    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                        .padding(.bottom, 20)

                    if loginData.registerUser {
                        CustomTextField(icon: "envelope", title: "Re-enter Password", hint: "12345", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }

                    Button {
                        if loginData.registerUser {
                            if loginData.registerUserValid() {
                                loginData.register { success in
                                    if success {
                                        navigateToMainPage = true
                                    } else {
                                        // Handle registration failure
                                        // For example, display an error message
                                        loginData.errorMessage = "Registration failed. Please try again."
                                    }
                                }
                            }
                        } else {
                            if loginData.loginUserValid() {
                                if loginData.login() {
                                    navigateToMainPage = true
                                } else {
                                    // Show the alert when login fails
                                    showErrorAlert = true
                                }
                            } else {
                                // Handle login failure
                                // For example, display an error message
                                loginData.errorMessage = "Please add the correct email & password!"
                            }
                        }
                    } label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.system(size: 17).lowercaseSmallCaps())
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("black"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    .disabled(loginData.logStatus)
                    .alert(isPresented: $showErrorAlert) {
                        Alert(
                            title: Text("Incorrect Information"),
                            message: Text("Please add the correct email & password!"),
                            primaryButton: .destructive(
                                Text(primaryButtonTitle),
                                action: {
                                    // Clear email and password fields
                                    loginData.email = ""
                                    loginData.password = ""
                                }
                            ),
                            secondaryButton: .cancel(
                                Text(secondaryButtonTitle),
                                action: {
                                    // Handle secondary button action here, if needed
                                }
                            )
                        )
                    }

                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to Login" : "Create Account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("black"))
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("black"))
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.reEnterPassword = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
            loginData.errorMessage = "" // Reset the errorMessage when switching between login and register
        }
        .onChange(of: loginData.email) { newValue in
            loginData.errorMessage = "" // Reset the errorMessage when the email field changes
        }
        .fullScreenCover(isPresented: $navigateToMainPage) {
            MainPage()
        }
    }
    @State private var isPressed: Bool = false
}


@ViewBuilder
func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
    VStack(alignment: .leading, spacing: 12) {
        Label {
            Text(title)
                .font(.system(size: 14))
        } icon: {
            Image(systemName: icon)
        }
        .foregroundColor(Color.black.opacity(0.8))

        if title.contains("Password") {
            if showPassword.wrappedValue {
                TextField(hint, text: value)
                    .padding(.top, 2)
            } else {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            }
        } else {
            TextField(hint, text: value)
                .padding(.top, 2)
        }

        Divider()
            .background(Color.black.opacity(0.4))
    }
    .overlay(
        Group {
            if title.contains("Password") {
                Button(action: {
                    showPassword.wrappedValue.toggle()
                }, label: {
                    Text(showPassword.wrappedValue ? "Hide" : "Show")
                        .font(.system(size: 13).bold())
                        .foregroundColor(.red)
                })
                .offset(y: 8)
            }
        }
    )
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(showLoginPage: .constant(true))
    }
}



