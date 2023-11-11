//
//  ShippingAddress.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 11/10/23.
//

// ShippingAddress.swift

import Foundation

struct ShippingAddress: Codable {
    var street: String
    var city: String
    var state: String
    var zipCode: String

    var isEmpty: Bool {
        return street.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty
    }
}

