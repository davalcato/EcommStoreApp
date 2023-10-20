//
//  PaymentPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

struct PaymentMethod: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct PaymentPage: View {
    @Binding var selectedPaymentMethod: PaymentMethod?
    @Binding var shippingAddress: ShippingAddress // Add this binding

    let paymentMethods: [PaymentMethod] = [
        PaymentMethod(name: "Visa"),
        PaymentMethod(name: "American Express"),
        PaymentMethod(name: "Apple Pay")
    ]

    init(selectedPaymentMethod: Binding<PaymentMethod?>, shippingAddress: Binding<ShippingAddress>) {
        self._selectedPaymentMethod = selectedPaymentMethod
        self._shippingAddress = shippingAddress
    }

    @State private var addNewPressed = false

    var body: some View {
        VStack {
            Text("Selected Payment Method: \(selectedPaymentMethod?.name ?? "None")")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            HStack {
                Text("Pay with:")
                    .font(.system(size: 10))
                    .padding(.leading, 20)

                Spacer()

                Button(action: {
                    // Add new payment method logic here
                }) {
                    Text("+ Add new")
                        .font(.system(size: 10))
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background(addNewPressed ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .onTapGesture {
                    addNewPressed.toggle()
                }
            }
            .padding(.horizontal, 20)

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

            NavigationLink(
                destination: ContinuePage(shippingAddress: shippingAddress),
                label: {
                    Text("Continue")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(15)
                }
            )
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}
