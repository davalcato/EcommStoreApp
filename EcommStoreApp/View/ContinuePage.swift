//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    let shippingAddress: ShippingAddress // Add the shippingAddress parameter
    let selectedProducts: [Product] // Add the selectedProducts parameter

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
                    ForEach(selectedProducts) { product in
                        Button(action: {
                            // Add action for the product button
                        }) {
                            VStack {
                                Image(product.productImage) // Use the product's image name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Adjust image size
                                Text(product.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .background(Color.blue) // Use appropriate color
                            .cornerRadius(15)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.3) // Adjust button size
                    }
                }
            }

            // Rest of your view
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
