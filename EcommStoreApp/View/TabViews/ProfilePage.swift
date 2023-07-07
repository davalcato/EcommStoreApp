//
//  ProfilePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("My Profile")
                        .font(.system(size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Image("Memo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        Text("Random Guin")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: IC Block Salt lake,\nKolkata, West Bengal")
                                .font(.system(size: 15))
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white.cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    // Custom Navigation Link
                    CustomNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Shopping Address") {
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Order History") {
                        Text("")
                            .navigationTitle("Order History")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Cards") {
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)

            }
            .navigationBarHidden(true)
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(
                Color("Color").ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        NavigationLink(destination: content()) {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white.cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
