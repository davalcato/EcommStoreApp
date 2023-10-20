//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    let shippingAddress: ShippingAddress // Add the shippingAddress parameter

    var body: some View {
        VStack {
            Text("Continue Page")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Spacer()

            // Display the shipping address
            Text("Shipping Address:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 20)

            Text("Street: \(shippingAddress.street)")
            Text("City: \(shippingAddress.city)")
            Text("State: \(shippingAddress.state)")
            Text("ZIP Code: \(shippingAddress.zipCode)")

            // Rest of your view

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

struct ContinuePage_Previews: PreviewProvider {
    static var previews: some View {
        // Sample shipping address for preview
        let sampleShippingAddress = ShippingAddress(street: "123 Main St", city: "Sample City", state: "CA", zipCode: "12345")

        return ContinuePage(shippingAddress: sampleShippingAddress)
    }
}

