//
//  LoginPageModel.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    //login properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //register
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    //Log Status
    @AppStorage("log_Status") var log_Status: Bool = false
    
    //login call
    func Login() {
        withAnimation{
            log_Status = true
        }
    }
    
    func Register() {
        withAnimation{
            log_Status = true
        }
    }
    
    func Forgotpassword() {
        
    }
    
  
}
