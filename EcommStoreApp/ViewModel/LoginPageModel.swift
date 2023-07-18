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
    func loginUserValid() -> Bool {
        // Add your login validation logic here
        // Return true if the login data is valid, false otherwise
        // For example:
        if email == "example@example.com" && password == "password" {
            return true
        } else {
            return false
        }
    }

    func registerUserValid() -> Bool {
        // Add your registration validation logic here
        // Return true if the registration data is valid, false otherwise
        // For example:
        if email.isValidEmail() && password.count >= 6 && password == reEnterPassword {
            return true
        } else {
            return false
        }
    }

    func Login() {
        if loginUserValid() {
            withAnimation {
                log_Status = true
            }
        } else {
            // Handle incorrect credentials
            // For example, display an error message
        }
    }

    func Register() {
        if registerUserValid() {
            // Add your registration logic here
            // You can store the registered user's information in a database or perform other actions
            withAnimation {
                log_Status = true
            }
        } else {
            // Handle invalid registration data
            // For example, display an error message
        }
    }

    func Forgotpassword() {
        // Add your forgot password logic here
    }
}

extension String {
    func isValidEmail() -> Bool {
        // Add your email validation logic here
        // Return true if the email is valid, false otherwise
        // For example, you can use regular expressions to validate the email format
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
