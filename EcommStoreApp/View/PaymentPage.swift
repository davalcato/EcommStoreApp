//
//  PaymentPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct CheckoutPage: View {
    let subtotal: String

    init(subtotal: String) {
        self.subtotal = subtotal
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
                    destination: PaymentPage(),
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


struct PaymentMethod: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct PaymentPage: View {
    @State private var selectedPaymentMethod: PaymentMethod?
    
    let paymentMethods: [PaymentMethod] = [
        PaymentMethod(name: "Visa"),
        PaymentMethod(name: "American Express"),
        PaymentMethod(name: "Apple Pay")
    ]

    var body: some View {
        VStack {
            Text("Select Payment Method")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Spacer()

            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(paymentMethods, id: \.self) { method in
                    PaymentMethodView(method: method, selectedPaymentMethod: $selectedPaymentMethod)
                        .onTapGesture {
                            selectedPaymentMethod = method
                        }
                }
            }
            .padding(.horizontal, 20)

            Spacer()

            if let selectedMethod = selectedPaymentMethod {
                Text("Selected Payment Method: \(selectedMethod.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
            } else {
                Text("No Payment Method Selected")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

