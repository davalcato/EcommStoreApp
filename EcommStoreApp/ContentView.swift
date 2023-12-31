//
//  ContentView.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    @EnvironmentObject var sharedData: SharedDataModel
    

    var body: some View {
        Group {
            if log_Status {
                MainPage()
            } else {
                OnBoardingPage()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
}
}
