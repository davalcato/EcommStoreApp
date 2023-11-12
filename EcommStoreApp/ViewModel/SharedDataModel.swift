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
        
        var total: Int = 0
        cartProducts.forEach{product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity  //see Product Model
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "$\(total)"
    }
    
}
