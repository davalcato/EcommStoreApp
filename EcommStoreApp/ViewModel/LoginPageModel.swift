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
    func Login(completion: @escaping (Bool) -> Void) {
        // Add your login logic here
        if email == "example@example.com" && password == "password" {
            withAnimation {
                log_Status = true
                completion(true)
            }
        } else {
            // Handle incorrect credentials
            // For example, display an error message
            completion(false)
        }
    }

    func Register(completion: @escaping (Bool) -> Void) {
        // Add your registration logic here
        // You can store the registered user's information in a database or perform other actions
        withAnimation {
            log_Status = true
            completion(true)
        }
    }

    func loginUserValid() -> Bool {
        // Add your login validation logic here
        // For example, check if the email and password meet the required criteria
        return !email.isEmpty && !password.isEmpty
    }

    func registerUserValid() -> Bool {
        // Add your registration validation logic here
        // For example, check if the email, password, and re-entered password meet the required criteria
        return !email.isEmpty && !password.isEmpty && password == reEnterPassword
    }
}
