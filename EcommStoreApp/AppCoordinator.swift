//
//  AppCoordinator.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/30/23.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        // Implement any logic here to check if the user is logged in
        // For simplicity, I'll set the initial value to false
        isLoggedIn = false
    }

    func logout() {
        isLoggedIn = false
    }

    func login() {
        isLoggedIn = true
    }
}
