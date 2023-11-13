//
//  SharedDataModel.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var selectedPaymentMethod: PaymentMethod?
    
    //Detail Product Data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    //matched geometry effect from search page
    @Published var fromSearchPage: Bool = false
    
    //Liked products
    @Published var likedProducts: [Product] = []
    
    //Cart products
    @Published var cartProducts: [Product] = []
    
    
    //calculating total price
    func getTotalPrice() -> String {
        var total: Double = 0.0

        cartProducts.forEach { product in
            let price = product.price
            let quantity = Double(product.quantity)
            let priceTotal = quantity * price
            total += priceTotal
        }

        return String(format: "$%.2f", total)
    }


  
}
