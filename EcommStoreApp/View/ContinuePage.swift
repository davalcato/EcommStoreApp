//
//  ContinuePage.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 10/17/23.
//

import SwiftUI

struct ContinuePage: View {
    var body: some View {
        VStack {
            Text("Continue Page")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}


struct ContinuePage_Previews: PreviewProvider {
    static var previews: some View {
        ContinuePage()
    }
}
