//
//  StaggeredGrid.swift
//  EcommStoreApp
//
//  Created by Daval Cato on 7/6/23.
//

import SwiftUI

//T -> is to hold the identifiable collection of data

struct StaggeredGrid<Content: View, T: Identifiable> : View where T: Hashable{
    
    //it will return each obect from collection to build view
    
    var content: (T) -> Content
    var list: [T]
    var coloumns: Int
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int, showsIndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.coloumns = columns
    }
    
    //Staggared grid func
    func setUpList() -> [[T]] {
        
        //creating empty subarray of columns count
        
        var gridArray: [[T]] = Array(repeating: [], count: coloumns)
        
        //spliting array for vstack oriented view
        var currentIndex: Int = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            
            //increasing index count and ressting if overbounds the columns count
            
            if currentIndex == (coloumns - 1) {
                currentIndex = 0
            }else{
                currentIndex += 1
            }
        }
        return gridArray
    }

    var body: some View {
        
        
            HStack(alignment: .top, spacing: 20){
                ForEach(setUpList(), id: \.self) {columnsData in
                    //for optimized we use lazystack
                    LazyVStack(spacing: spacing) {
                        ForEach(columnsData){object in
                            content(object)
                        }
                    }
                    .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
                }
            }
            //only vertical padding
            //horizontal padding will be user's optional
            .padding(.vertical)
        
    }
    
    //moving second row little down
    func getIndex(values: [T]) -> Int {
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        
        return index
    }
}
