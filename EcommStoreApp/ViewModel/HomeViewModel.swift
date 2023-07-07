//
//  HomeViewModel.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

//Using Combine to monitor search field and if user leaves for 0.5 sec then starts searching to avoid memory issue
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .Wearable
    
    //sample products
    
    @Published var products: [Product] = [
    
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
    
    //Filtered products
    @Published var filteredproducts: [Product] = []
    
    //more products on type
    @Published var showMoreProductsOnType: Bool = false
    
    //search data
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != ""{
                    self.filterProductBySearch()
                }else{
                    self.searchedProducts = nil
                }
            })
    }
    
    
    func filterProductByType() {
        
        //filter by product type
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            //since it will require more memory we will lazy to perform more
                .lazy
                .filter {products in
                    return products.type == self.productType
                }
            
            //limiting result
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredproducts = results.compactMap({products in
                    return products
                })
            }
        }
        
    }
    
    func filterProductBySearch() {
        
        //filter by product type
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            //since it will require more memory we will lazy to perform more
                .lazy
                .filter {products in
                    return products.title.lowercased().contains(self.searchText.lowercased())
                }
            

            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({products in
                    return products
                })
            }
        }
        
    }
    
}
