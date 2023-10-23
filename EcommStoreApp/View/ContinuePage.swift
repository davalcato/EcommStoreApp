//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    let shippingAddress: ShippingAddress // Add the shippingAddress parameter

    var body: some View {
        VStack {
            Text("Continue Page")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Spacer()

            // Display the shipping address
            Text("Shipping Address:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            Text("Street: \(shippingAddress.street)")
            Text("City: \(shippingAddress.city)")
            Text("State: \(shippingAddress.state)")
            Text("ZIP Code: \(shippingAddress.zipCode)")

            // Display the items from the CartPage
            Text("Items from CartPage:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: {
                        // Add action for the first button
                    }) {
                        VStack {
                            Image("Item1") // Replace "Item1" with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100) // Adjust image size
                            Text("Button 1")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.blue)
                        .cornerRadius(15)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3) // Adjust button size

                    Button(action: {
                        // Add action for the second button
                    }) {
                        VStack {
                            Image("Item2") // Replace "Item2" with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100) // Adjust image size
                            Text("Button 2")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.green)
                        .cornerRadius(15)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3) // Adjust button size
                }
            }

            // Rest of your view
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
