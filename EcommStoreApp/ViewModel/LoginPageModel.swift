//
//  LoginPageModel.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    // Login properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    // Register properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false

    // Log Status
    @AppStorage("log_Status") var log_Status: Bool = false

    // Login call
    func Login() {
        // Add your login logic here
        if email == "example@example.com" && password == "password" {
            withAnimation {
                log_Status = true
            }
        } else {
            // Handle incorrect credentials
            // For example, display an error message
        }
    }

    func Register() {
        // Add your registration logic here
        // You can store the registered user's information in a database or perform other actions
        withAnimation {
            log_Status = true
        }
    }

    func Forgotpassword() {
        // Add your forgot password logic here
    }
}
