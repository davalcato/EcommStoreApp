//
//  EcommStoreAppApp.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

@main
struct EcommStoreAppApp: App {
    @StateObject private var sharedData = SharedDataModel()

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(sharedData)
            }
        }
    }
