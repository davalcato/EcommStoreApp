//
//  CheckoutPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct ShippingAddress: Codable {
    var street: String
    var city: String
    var state: String
    var zipCode: String
}

struct CheckoutPage: View {
    let subtotal: String
    @Binding var selectedPaymentMethod: PaymentMethod?
    
    @State private var isSaving = false

    @State private var shippingAddress = ShippingAddress(street: "", city: "", state: "", zipCode: "")
    @State private var promoCode: String = ""
    @State private var savingAddress = false // Added a state for saving address

    init(subtotal: String, selectedPaymentMethod: Binding<PaymentMethod?>) {
        self.subtotal = subtotal
        self._selectedPaymentMethod = selectedPaymentMethod

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
                        ZStack {
                            Text("Proceed to Payment")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(15)

                            if savingAddress {
                                ActivityIndicator(title: "Saving", isAnimating: $savingAddress)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                )
                .padding(.horizontal, 20)
                .onTapGesture {
                    savingAddress = true // Start saving address
                    // Save the address to UserDefaults
                    if let addressData = try? JSONEncoder().encode(shippingAddress) {
                        UserDefaults.standard.set(addressData, forKey: "shippingAddress")
                    }
                    // Stop the activity indicator after a brief delay (simulating a save operation)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        savingAddress = false
                    }
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    let title: String
    @Binding var isAnimating: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct CheckoutPage_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutPage(subtotal: "100.00", selectedPaymentMethod: .constant(nil))
    }
}
