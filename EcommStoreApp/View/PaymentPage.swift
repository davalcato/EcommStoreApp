//
//  PaymentPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/13/23.
//

import SwiftUI

let selectedProducts: [Product] = [
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "AppleWatch6"),
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 7: Green", price: "$559", productImage: "AppleWatch7"),
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 4: Space Grey", price: "$250", productImage: "AppleWatch4"),
    
    
    Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "iPhone13"),
    Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "iPhone12"),
    Product(type: .Phones, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "iPhone11"),
    Product(type: .Phones, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399", productImage: "iPhoneSE2"),
    
    
    Product(type: .Laptops, title: "MacBook Air", subtitle: "M1 - Gold", price: "$999", productImage: "MAir"),
    Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "MPro"),
    
    Product(type: .Tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999", productImage: "Pro"),
    Product(type: .Tablets, title: "iPad Air 4", subtitle: "A14 - Rose Gold", price: "$699", productImage: "Air4"),
    Product(type: .Tablets, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599", productImage: "Mini"),
    
    Product(type: .Laptops, title: "iMac", subtitle: "M1 - Purple", price: "$1599", productImage: "iMac")


]

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
