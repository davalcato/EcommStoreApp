//
//  LikedPage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Favourites").font(.system(size: 28).bold())) {
                    if sharedData.likedProducts.isEmpty {
                        // Display this content if there are no liked products
                        EmptyLikedProductsView()
                    } else {
                        ForEach(sharedData.likedProducts) { product in
                            CardView(product: product)
                        }
                        .onDelete(perform: deleteProducts)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing:
                EditButton()
            )
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
            .background(Color("Color").ignoresSafeArea())
        }
    }
    
    func deleteProducts(at offsets: IndexSet) {
        sharedData.likedProducts.remove(atOffsets: offsets)
    }
    
    @ViewBuilder
    func CardView(product: Product) -> some View {
        
        HStack(spacing: 15) {
            
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
                
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
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
    
    struct EmptyLikedProductsView: View {
        var body: some View {
            Group {
                Image("cat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .padding(.top, 35)
                Text("No favourites yet!")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                
                Text("Hit the like button on each product page to save favorite ones.")
                    .font(.system(size: 18).bold())
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
