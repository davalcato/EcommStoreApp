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
    @State private var orderTotal: Double = 0.0

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: 10) {
                ForEach(["Order Summary:", "Total before Tax:", "Estimated Tax:", "Order Total:"], id: \.self) { item in
                    if item == "Order Total:" {
                        HStack {
                            Text(item)
                            Spacer()
                            Text(String(format: "$%.2f", orderTotal))
                        }
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                    } else {
                        Text(item)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                    }
                }
            }

            // Container for the "Order Summary"
            VStack {
                // Number of items added to the basket
                Text("Items Added: \(selectedProductsInCart.count)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, -5)
                    .font(.system(size: 11))

                // Shipping Address
                Text("Shipping Address:")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 10)

                Text("Street: \(shippingAddress.street)")
                Text("City: \(shippingAddress.city)")
                Text("State: \(shippingAddress.state)")
                Text("ZIP Code: \(shippingAddress.zipCode)")
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
                            showDeleteConfirmation = true
                            productToDelete = product
                        }) {
                            VStack {
                                Image(product.productImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                Text(product.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                }
            }

            Spacer()
        }
        .onAppear {
            selectedProductsInCart = sharedData.cartProducts
            orderTotal = calculateTotalBeforeTax()
        }
        .onDisappear {
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
                        if let sharedIndex = sharedData.cartProducts.firstIndex(of: product) {
                            sharedData.cartProducts.remove(at: sharedIndex)
                        }
                        showDeleteConfirmation = false
                    }
                },
                secondaryButton: .cancel(Text("Cancel")) {
                    showDeleteConfirmation = false
                }
            )
        }
    }

    func calculateTotalBeforeTax() -> Double {
        return selectedProductsInCart.reduce(0.0) { $0 + (Double($1.price) ?? 0.0) }
    }

}
