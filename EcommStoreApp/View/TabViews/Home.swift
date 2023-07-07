//
//  Home.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    //shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
   
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                //search bar
                ZStack {
                    if homeData.searchActivated {
                        SearchBar()
                    } else {
                        SearchBar().matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                Text("order online\ncollect in store")
                    .font(.system(size: 28).lowercaseSmallCaps().bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                
                
                
                //products tab
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 25) {
                        ForEach(ProductType.allCases, id: \.self) {type in
                            
                            //Product type view
                            ProductTypeView(types: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                //product page
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredproducts) {product in
                            
                            //card view
                            ProductCardView(products: product)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 30)
                
                //see more button
                //this button will show all products on the current product type
                //since here were showing only 4
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                }label: {
                    
                    Label {
                        
                        Image(systemName: "arrow.right")
                        
                    }icon: {
                        
                        Text("See More")
                        
                    }
                    .font(.system(size: 15).bold())
                    .foregroundColor(Color("black"))
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color"))
        
        //updating data whenever tab changes(producttype)
        .onChange(of: homeData.productType) {newValue in
            homeData.filterProductByType()
        }
        
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        
        //Displaying search view
        .overlay(
        
            ZStack {
                if homeData.searchActivated {
                    if #available(iOS 15.0, *) {
                        SearchView(animation: animation).environmentObject(homeData)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        )
        
    }
    
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            //since we need a separate view for search bar
            TextField("Search", text: .constant("")).disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
        
        Capsule()
            .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCardView(products: Product) -> some View {
        
        VStack(spacing: 10) {
            //adding matched geometry effect
            ZStack{
                if sharedData.showDetailProduct{
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }else{
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(products.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().height / 4.5)
            
            //(IMPORTANT) not for me
            //moving image to top
                //.offset(y: -80)
                //.padding(.bottom, -80)
            
            Text(products.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(products.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .fontWeight(.semibold)
            
            Text(products.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("black"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        
        //.padding(.top, 80)
        
        //showing product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.detailProduct = products
                sharedData.showDetailProduct = true
            }
        }
    }
    
    
    @ViewBuilder
    func ProductTypeView(types: ProductType) -> some View {
        
        Button {
            //updating currnet type
            withAnimation {
                homeData.productType = types
            }
        } label: {
            Text(types.rawValue)
                .font(.system(size: 15))
                .fontWeight(.bold)
            //changing color based on current product type
                .foregroundColor(homeData.productType == types ? Color("black") : Color.gray)
                .padding(.bottom, 10)
            
            //adding indicator at bottom
                .overlay(
                    
                    //adding matched geometry effect
                    
                    ZStack {
                        if homeData.productType == types {
                            Capsule()
                                .fill(Color("black"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
