//
//  CheckoutPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct CheckoutPage: View {
    let subtotal: String
    @Binding var selectedPaymentMethod: PaymentMethod?
    @State private var shippingAddress: ShippingAddress
    @State private var promoCode: String = ""
    @State private var isSavingAddress = false
    @State private var showAlert = false
    
    init(subtotal: String, selectedPaymentMethod: Binding<PaymentMethod?>) {
        self.subtotal = subtotal
        self._selectedPaymentMethod = selectedPaymentMethod
        // Load the address from UserDefaults when the view initializes
        if let savedAddressData = UserDefaults.standard.data(forKey: "shippingAddress"),
           let savedAddress = try? JSONDecoder().decode(ShippingAddress.self, from: savedAddressData) {
            self._shippingAddress = State(initialValue: savedAddress)
        } else {
            self._shippingAddress = State(initialValue: ShippingAddress(street: "", city: "", state: "", zipCode: ""))
        }
    }

    var body: some View {
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

            TextField("Promo Code", text: $promoCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

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
            .disabled(isSavingAddress || shippingAddress.isEmpty)
            .onTapGesture {
                // Save the address to UserDefaults
                isSavingAddress = true
                saveAddress()
            }

            // Activity Indicator to show "Save"
            if isSavingAddress {
                ProgressView {
                    Text("Saved")
                        .font(.title2)
                        .bold()  // Make the text bold
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Missing Address"),
                message: Text("Please enter your shipping address before proceeding."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func saveAddress() {
        DispatchQueue.global().async {
            // Simulate a delay for demonstration purposes
            Thread.sleep(forTimeInterval: 2)
            // Save the address to UserDefaults
            if !shippingAddress.isEmpty {
                if let addressData = try? JSONEncoder().encode(shippingAddress) {
                    UserDefaults.standard.set(addressData, forKey: "shippingAddress")
                }
                isSavingAddress = false
            } else {
                showAlert = true
                isSavingAddress = false
            }
        }
    }
}
