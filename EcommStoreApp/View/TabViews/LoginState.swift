//
//  LoginState.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/29/23.
//

import SwiftUI

// Define LoginState as an ObservableObject
class LoginState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
