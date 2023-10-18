//
//  CheckoutPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct CheckoutPage: View {
    let subtotal: String
    @Binding var selectedPaymentMethod: PaymentMethod? // Add this binding

    init(subtotal: String, selectedPaymentMethod: Binding<PaymentMethod?>) {
        self.subtotal = subtotal
        self._selectedPaymentMethod = selectedPaymentMethod
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Checkout")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Spacer()

                HStack {
                    Text("Subtotal")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                    Text(subtotal)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 20)

                Spacer()

                // Add more checkout details, buttons, and other UI elements here

                NavigationLink(
                    destination: PaymentPage(selectedPaymentMethod: $selectedPaymentMethod),
                    label: {
                        Text("Proceed to Payment")
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
            .navigationBarHidden(true) // Hide the navigation bar in this view
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}












//
//    struct CheckoutPage: View {
//        let subtotal: String
//
//        init(subtotal: String) {
//            self.subtotal = subtotal
//        }
//
//        var body: some View {
//            NavigationView {
//                VStack {
//                    Text("Checkout")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding(.top, 20)
//
//                    Spacer()
//
//                    HStack {
//                        Text("Subtotal")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//
//                        Spacer()
//
//                        Text(subtotal)
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                    }
//                    .padding(.horizontal, 20)
//
//                    Spacer()
//
//                    // Add more checkout details, buttons, and other UI elements here
//
//                    NavigationLink(
//                        destination: PaymentPage(), // You can replace PaymentPage with the next step in your checkout process
//                        label: {
//                            Text("Proceed to Payment")
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .cornerRadius(15)
//                        }
//                    )
//                    .padding(.horizontal, 20)
//                }
//                .navigationBarHidden(true)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color(.systemGray6).ignoresSafeArea())
//            }
//        }
//    }
