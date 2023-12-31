//
//  MainPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct MainPage: View {
    
    //current tab
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    //animation namespace
    @Namespace var animation
    //Hiding TabBar
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
       
        VStack(spacing: 0) {
            
            //Tab View
            TabView(selection: $currentTab) {
                
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
            
            //Custom tab Bar
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) {tab in
                    
                    Button {
                        //updating tab
                        currentTab = tab
                        
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        //applying little shadow at bg
                            .background(
                            
                                Color("black")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7) //making little big
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("black") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom, 10)
        }
        .background(Color("Color").ignoresSafeArea())
        
        .overlay(
            ZStack{
                //detail page
                if let product = sharedData.detailProduct, sharedData.showDetailProduct{
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    
                    //adding transitions
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}


