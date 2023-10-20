//
//  CheckoutPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

// Define a struct to represent the user's shipping address
struct ShippingAddress: Codable {
    var street: String
    var city: String
    var state: String
    var zipCode: String
}

struct CheckoutPage: View {
    let subtotal: String
    @Binding var selectedPaymentMethod: PaymentMethod?

    // Create an instance of ShippingAddress to store the address information
    @State private var shippingAddress = ShippingAddress(street: "", city: "", state: "", zipCode: "")

    @State private var promoCode: String = "" // Added promo code property

    init(subtotal: String, selectedPaymentMethod: Binding<PaymentMethod?>) {
        self.subtotal = subtotal
        self._selectedPaymentMethod = selectedPaymentMethod

        // Load the stored address from UserDefaults if available
        if let storedAddressData = UserDefaults.standard.data(forKey: "shippingAddress"),
           let storedAddress = try? JSONDecoder().decode(ShippingAddress.self, from: storedAddressData) {
            self._shippingAddress = State(initialValue: storedAddress)
        }
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

                // Shipping Address
                TextField("Street", text: $shippingAddress.street)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                TextField("City", text: $shippingAddress.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                TextField("State", text: $shippingAddress.state)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                TextField("ZIP Code", text: $shippingAddress.zipCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                // Promo Code Field
                TextField("Promo Code", text: $promoCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                // ... (Rest of your view)

                // Save the address when the "Proceed to Payment" button is tapped
                NavigationLink(
                    destination: PaymentPage(selectedPaymentMethod: $selectedPaymentMethod, shippingAddress: $shippingAddress),
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
                .onTapGesture {
                    // Save the address to UserDefaults
                    if let addressData = try? JSONEncoder().encode(shippingAddress) {
                        UserDefaults.standard.set(addressData, forKey: "shippingAddress")
                    }
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}
