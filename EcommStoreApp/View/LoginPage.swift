//
//  LoginPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack {
            
                Text("Welcome\nBack")
                    .font(.system(size: 55).lowercaseSmallCaps()).bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                
                .frame(height: getRect().height / 3.5)
                .padding()
            
                .background(
                
                    ZStack {
                        
                        //gradient circle
                            LinearGradient(colors: [
                                Color("LC1"),
                                Color("LC2").opacity(0.8),
                                Color("black")
                            
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
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.system(size: 22).lowercaseSmallCaps().bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //custom textfield
                    CustomTextField(icon: "envelope", title: "Email", hint: "rumenguin@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    
                    //register re enter
                    if loginData.registerUser {
                        CustomTextField(icon: "envelope", title: "Re-enter Password", hint: "12345", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //forgot password button
                    
                    Button {
                        loginData.Forgotpassword()
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("black"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    //login button
                    
                    Button {
                        if loginData.registerUser {
                            loginData.Register()
                        }
                        else {
                            loginData.Login()
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
                    
                    
                    
                    //register user button
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
            .background(Color.white
            //applying custom corners
                            .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                            .ignoresSafeArea()
            
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("black"))
        
        //clearing data when changes
        
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
        
        //showing show button for password field
        .overlay(
        
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13).bold())
                            .foregroundColor(Color("black"))
                    })
                        .offset(y: 8)
                   
                }
                
            }
            , alignment: .trailing
        
        )
    }
        
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            LoginPage()
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
