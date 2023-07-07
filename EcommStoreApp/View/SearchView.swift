//
//  SearchView.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct SearchView: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    
    //shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    //activating textfield with the help of focusstate
    @FocusState var startTF: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            //search bar
            HStack(spacing: 20) {
                //close button
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    
                    //resetting
                    sharedData.fromSearchPage = false
                }label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                //SearchBar()
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    //since we need a separate view for search bar
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                
                
                .background(
                Capsule()
                    .strokeBorder(Color("black"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            
            
            //showingprogress if searching
            //else showing no result found if empty
            if let products = homeData.searchedProducts {
                if products.isEmpty{
                    
                    //No results found
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                            
                        
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    .padding()
                    
                }else{
                    //filter search
                    ScrollView(.vertical, showsIndicators: false) {
                        //staggered grid
                        VStack(spacing: 0) {
                            
                            //found text
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .padding(.vertical)
                            
                            
                            StaggeredGrid(columns: 2,spacing: 20, list: products) {product in
                                //card view
                                ProductCardView(products: product)
                            }
                        }
                        .padding()
                    }
                }
            }else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
        Color("Color")
            .ignoresSafeArea()
        )
        
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
        
    }
    
    
    
    
    
    @ViewBuilder
    func ProductCardView(products: Product) -> some View {
        
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct{
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }else{
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(products.id)SEARCH", in: animation)
                }
            }
               // .frame(width: getRect().width / 2.5, height: getRect().height / 4.5)
            
            //(IMPORTANT) not for me
            //moving image to top
                //.offset(y: -80)
               // .padding(.bottom, -80)
            
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
        //showing product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = products
                sharedData.showDetailProduct = true
            }
        }
        //.padding(.top, 80)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
