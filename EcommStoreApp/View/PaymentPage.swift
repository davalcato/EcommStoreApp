//
//  PaymentPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct PaymentPage: View {
    var body: some View {
        VStack {
            Text("Payment Page")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Spacer()

            // Add payment-related content here

            Spacer()

            NavigationLink(
                destination: Text("Order Confirmed"), // Replace with your order confirmation page
                label: {
                    Text("Confirm Payment")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            )
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true) // Hide the navigation bar
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}


