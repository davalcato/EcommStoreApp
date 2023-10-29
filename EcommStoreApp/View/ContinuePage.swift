//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    let shippingAddress: ShippingAddress
    @EnvironmentObject var sharedData: SharedDataModel
    @State private var selectedProductsInCart: [Product] = []
    @State private var showDeleteConfirmation = false
    @State private var productToDelete: Product?

    var body: some View {
        VStack {
            Text("Continue Page")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Container for the "Order Summary"
            VStack {
                Text("Order Summary")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                
                // Shipping Address
                Text("Shipping Address:")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)

                Text("Street: \(shippingAddress.street)")
                Text("City: \(shippingAddress.city)")
                Text("State: \(shippingAddress.state)")
                Text("ZIP Code: \(shippingAddress.zipCode)")

                // Number of items added to the basket
                Text("Items Added: \(selectedProductsInCart.count)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
                // Rest of your view
            }

            Spacer()

            // Display the items added to the basket
            Text("Added to Basket:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(selectedProductsInCart) { product in
                        Button(action: {
                            // Display delete confirmation pop-up
                            showDeleteConfirmation = true
                            productToDelete = product
                        }) {
                            VStack {
                                Image(product.productImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
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
        }
        .onAppear {
            // Populate selectedProductsInCart with products from shared data
            selectedProductsInCart = sharedData.cartProducts
        }
        .onDisappear {
            // Clear the selectedProductsInCart when leaving the view
            selectedProductsInCart.removeAll()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this product from your basket?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let product = productToDelete, let index = selectedProductsInCart.firstIndex(of: product) {
                        selectedProductsInCart.remove(at: index)
                        // Also remove the product from sharedData.cartProducts
                        if let sharedIndex = sharedData.cartProducts.firstIndex(of: product) {
                            sharedData.cartProducts.remove(at: sharedIndex)
                        }
                    }
                    showDeleteConfirmation = false
                },
                secondaryButton: .cancel(Text("Cancel")) {
                    showDeleteConfirmation = false
                }
            )
        }
    }
}
