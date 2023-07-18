//
//  LoginPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State private var draggedOffset: CGSize = .zero
    @Binding var showLoginPage: Bool // Add a binding for controlling the visibility of LoginPage
    @State private var isLogged: Bool = false // Add a state variable to track login status

    var body: some View {
        VStack {
            Button {
                showLoginPage = false // Update the binding to dismiss LoginPage
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
                        showLoginPage = false // Update the binding to dismiss LoginPage
                    }
            )

            Text("Welcome\nBack")
                .font(.system(size: 55).lowercaseSmallCaps()).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack {
                        LinearGradient(colors: [
                            Color("LC1"),
                            Color("LC2").opacity(0.8),
                            Color("red")
                        ],
                        startPoint: .top, endPoint: .bottom)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()

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
                            if draggedOffset.width > 100 { // Check if the swipe is towards the right direction
                                showLoginPage = false // Update the binding to dismiss LoginPage
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

                    // Custom textfield
                    CustomTextField(icon: "envelope", title: "Email", hint: "rumenguin@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)

                    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                        .padding(.bottom, 20) // Add padding to control keyboard positioning

                    if loginData.registerUser {
                        CustomTextField(icon: "envelope", title: "Re-enter Password", hint: "12345", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }

                    Button(action: {
                        if loginData.registerUser {
                            if loginData.registerUserValid() {
                                loginData.Register()
                            }
                        } else {
                            if loginData.loginUserValid() {
                                isLogged = true // Set login status to true if correct credentials are provided
                            }
                        }
                    }) {
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
                    .disabled(isLogged) // Disable the login button if already logged in

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
        }
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

            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top,2)
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
}

