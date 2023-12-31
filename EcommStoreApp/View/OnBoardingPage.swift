//
//  OnBoardingPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct OnBoardingPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State var showLoginPage: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find your\nGadget")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .foregroundColor(Color("black"))
            
            Image("Board")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
            } label: {
                Text("Get Started")
                    .font(.system(size: 18).lowercaseSmallCaps())
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color("black"))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
            
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 20 : 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.white
        )
        .overlay(
            Group{
                if showLoginPage {
                    LoginPage(loginData: loginData, showLoginPage: $showLoginPage) // Pass the LoginPageModel and the binding variable
                        .transition(.move(edge: .bottom))
                        .zIndex(1) // Ensure the LoginPage is above the OnBoardingPage
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

// Extending view
extension View {
    func getRect()-> CGRect {
        return UIScreen.main.bounds
    }
}
