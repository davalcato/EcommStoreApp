//
//  ProfilePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI
import KeychainSwift

struct ProfilePage: View {
    @State private var showLogoutAlert = false
    @State private var navigateToLoginPage = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("My Profile")
                            .font(.system(size: 28).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            Image(systemName: "power")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 20) // Add padding to the right of the button
                    }
                    
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
                    
                    .padding(.horizontal, 22)
                    .padding(.top, 10) // Adjust the top padding
                    
                    CustomNavigationLink(title: "Shopping Address") {
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 10) // Adjust the top padding
                    
                    CustomNavigationLink(title: "Order History") {
                        Text("")
                            .navigationTitle("Order History")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    
                    .padding(.horizontal, 22)
                    .padding(.top, 10) // Adjust the top padding
                    
                    CustomNavigationLink(title: "Cards") {
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    
                    .padding(.horizontal, 22)
                    .padding(.top, 10) // Adjust the top padding
                    
                    CustomNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                            .background(
                                Color("Color").ignoresSafeArea())
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 10) // Adjust the top padding
                        
                    // Logout Custom Navigation Link
                                        CustomNavigationLink(title: "Logout") {
                                            EmptyView()
                                                .onAppear {
                                                    showLogoutAlert = true
                                                }
                                        }
                                        .padding(.horizontal, 22)
                                        .padding(.top, 20) // Adjust the top padding
                                    }
                                    .navigationBarHidden(true)
                                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                                    .background(
                                        Color("Color").ignoresSafeArea()
                                    )
                                }
                                .alert(isPresented: $showLogoutAlert) {
                                    Alert(
                                        title: Text("LOGOUT"),
                                        message: Text("Are you sure you want to Logout?"),
                                        primaryButton: .destructive(
                                            Text("Logout"),
                                            action: {
                                                // Handle Logout action here
                                                // For example, clear user session or show login screen
                                                UserDefaults.standard.removeObject(forKey: "log_Status")
                                                navigateToLoginPage = true // Set the state to trigger NavigationLink
                                            }
                                        ),
                                        secondaryButton: .cancel(Text("Cancel"))
                                    )
                                }
                                .fullScreenCover(isPresented: $navigateToLoginPage) {
                                    LoginPage(showLoginPage: $navigateToLoginPage)
                                }
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
        
