//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    let shippingAddress: ShippingAddress
    @EnvironmentObject var sharedData: SharedDataModel // Access to shared data
    @State private var selectedProductsInCart: [Product] = []

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

            // Display the items added to the basket
            Text("Added to Basket:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(selectedProductsInCart) { product in
                        Button(action: {
                            // Add action for the product button
                        }) {
                            VStack {
                                Image(product.productImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100) // Adjust image size
                                Text(product.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                    }
                }
            }

            Spacer()

            // Rest of your view

        }
        .onAppear {
            // Populate selectedProductsInCart with products from shared data
            selectedProductsInCart = sharedData.cartProducts
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}


