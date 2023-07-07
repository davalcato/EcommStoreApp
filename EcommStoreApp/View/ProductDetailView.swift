//
//  ProductDetailView.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    //for matched geometry effect
    var animation: Namespace.ID
    
    //shared data model
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        VStack {
            //title bar and product Image
            VStack {
                //title bar
                HStack {
                    
                    Button {
                        //closing view
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    
                    Button{
                        addToLiked()
                    }label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                //Product Image
                //Adding matched geometry effect
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            //product details
            ScrollView(.vertical, showsIndicators: false) {
                
                //Product data
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.system(size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.system(size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/month after free trial.")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    Button{
                        
                    }label: {
                        //since we need image at right
                        Label{
                            Image(systemName: "arrow.right")
                        }icon: {
                            Text("Full Description")
                            
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color("black"))
                    }
                    
                    HStack{
                        Text("Total")
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("black"))
                    }
                    .padding(.vertical, 20)
                    
                    //Add button basket
                    Button{
                        addToCart()
                    }label: {
                        Text("\(isAddedToCart() ? "Added" : "Add" ) to Basket")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("Color"))
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                            Color("black")
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                    
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Color")
                            //corner radius for only top side
    .           clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color.white.ignoresSafeArea())
        
    }
    func addToLiked() {
        
        if let index = sharedData.likedProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }){
            //remove from liked
            sharedData.likedProducts.remove(at: index)
        }
        else{
            //add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart() {
        
        if let index = sharedData.cartProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }){
            //remove from cart
            sharedData.cartProducts.remove(at: index)
        }
        else{
            //add to cart
            sharedData.cartProducts.append(product)
        }
    }
    
    //for like turning red color
    func isLiked() -> Bool {
        
        return sharedData.likedProducts.contains {product in
            
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart() -> Bool {
        
        return sharedData.cartProducts.contains {product in
            
            return self.product.id == product.id
        }
    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        ContentView()
    }
}
