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

    let paymentMethods: [PaymentMethod] = [
        PaymentMethod(name: "Visa"),
        PaymentMethod(name: "American Express"),
        PaymentMethod(name: "Apple Pay")
    ]

    init(selectedPaymentMethod: Binding<PaymentMethod?>) {
        self._selectedPaymentMethod = selectedPaymentMethod
    }

    @State private var addNewPressed = false

    var body: some View {
        VStack {
            HStack {
                Text("Select Payment Method")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

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

            if let selectedMethod = selectedPaymentMethod {
                Text("Selected Payment Method: \(selectedMethod.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                NavigationLink(
                    destination: ContinuePage(),
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
            } else {
                Text("No Payment Method Selected")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}
