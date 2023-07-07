//
//  CartPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct CartPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //delete option
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 10) {
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        HStack{
                            Text("Basket")
                                .font(.system(size: 28).bold())
                            
                            Spacer()
                            
                            Button{
                                withAnimation{
                                    showDeleteOption.toggle()
                                }
                            }label: {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        //checking if liked products are empty
                        if sharedData.cartProducts.isEmpty{
                            Group{
                                Image("empty-cart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("black"))
                                    .padding()
                                    .padding(.top, 35)
                                Text("No items added!")
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("Hit the plus button to save into basket.")
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                            }
                        }else{
                            //displaying products
                            VStack(spacing: 15) {
                                //for designing
                                ForEach($sharedData.cartProducts){$product in
                                    HStack(spacing: 0) {
                                        
                                        if showDeleteOption{
                                            Button{
                                                deleteProduct(product: product)
                                            }label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)
                                        }
                                        
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                //showing total and check out button
                if !sharedData.cartProducts.isEmpty{
                    Group{
                        HStack{
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.system(size: 18).bold())
                                .foregroundColor(Color("black"))
                        }
                        
                        Button{
                            
                        }label: {
                            Text("Checkout")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color("black"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("Color").ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product) {
        
        if let index = sharedData.cartProducts.firstIndex(where: {currentProduct in
            
            return product.id == currentProduct.id

        }){
            let _ = withAnimation{
                //removing
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View {
    //making product as binding so as to update in real time
    @Binding var product: Product
    
   
    
   
    var body: some View{
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.system(size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("black"))
                
                //quantity button
                HStack(spacing: 10) {
                    Text("Quantity")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Button{
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    }label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "minus")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(.teal)
                                .cornerRadius(4)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                    Text("\(product.quantity)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button{
                        product.quantity += 1
                    }label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "plus")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(.teal)
                                .cornerRadius(4)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
}
