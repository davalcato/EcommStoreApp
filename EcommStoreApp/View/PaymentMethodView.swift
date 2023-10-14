//
//  PaymentMethodView.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/14/23.
//

import SwiftUI

struct PaymentMethodView: View {
    let method: PaymentMethod
    @Binding var selectedPaymentMethod: PaymentMethod?

    var body: some View {
        VStack {
            Image(systemName: "creditcard.fill") // You can use your own image asset
                .font(.largeTitle)
                .foregroundColor(selectedPaymentMethod == method ? .blue : .gray)
                .onTapGesture {
                    selectedPaymentMethod = method
                }

            Text(method.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView(method: PaymentMethod(name: "Visa"), selectedPaymentMethod: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}


