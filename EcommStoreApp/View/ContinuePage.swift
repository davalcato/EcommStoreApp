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
    @State private var showDeleteConfirmation = false
    @State private var productToDelete: Product?
    @State private var orderTotal: Double = 0.0
    

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: 10) {
                ForEach(["Item price:", "Shipping:", "Sales Tax:", "Subtotal:"], id: \.self) { item in
                    if item == "Subtotal:" {
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
            
            Divider() // Add a divider under "Subtotal:"
            
            // Container for the "Order Summary"
            VStack {
                // Number of items added to the basket
                Text("Items Added: \(sharedData.cartProducts.count)")
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
                
                Divider() // Add a divider line below "ZIP Code"
                    .background(Color(.systemGray4)) // Customize the divider color if needed
            }

            Spacer()

            // Display the items added to the basket
            Text("Added to Basket:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(sharedData.cartProducts) { product in
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
            // Calculate the total before tax
            orderTotal = calculateTotalBeforeTax()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this product from your basket?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let product = productToDelete, let index = sharedData.cartProducts.firstIndex(of: product) {
                        sharedData.cartProducts.remove(at: index)

                        // Recalculate the total
                        orderTotal = calculateTotalBeforeTax()
                    }
                },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }

    func calculateTotalBeforeTax() -> Double {
        return sharedData.cartProducts.reduce(0.0) { $0 + (Double($1.price) ?? 0.0) }
    }
}
