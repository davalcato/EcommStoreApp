//
//  LoginPageModel.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI
import KeychainSwift

class LoginPageModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var errorMessage: String = ""

    // Log Status
    @AppStorage("log_Status") var logStatus: Bool = false

    // Keychain
    let keychain = KeychainSwift()

    func login() -> Bool {
        // Check if the user's input matches the stored account information
        if let savedEmail = keychain.get("email"),
           let savedPassword = keychain.get("password"),
           email == savedEmail,
           password == savedPassword {
            logStatus = true
            return true
        } else {
            // Handle incorrect credentials
            // For example, set an error message
            errorMessage = "Incorrect email or password. Please try again."
            return false
        }
    }

    func register(completion: @escaping (Bool) -> Void) {
        // Add your registration logic here
        // You can store the registered user's information in the Keychain
        keychain.set(email, forKey: "email")
        keychain.set(password, forKey: "password")
        logStatus = true

        // Call completion with success
        completion(true)
    }

    func registerUserValid() -> Bool {
        // Add validation logic for registration here
        // For example, check if email and password are valid
        // For this example, we'll assume they are valid
        return true
    }

    func loginUserValid() -> Bool {
        // Add validation logic for login here
        // For example, check if email and password are not empty
        // For this example, we'll assume they are valid
        return !email.isEmpty && !password.isEmpty
    }
}
