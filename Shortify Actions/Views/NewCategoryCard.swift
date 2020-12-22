//
//  NewCategoryCard.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import SwiftUI

struct NewCategoryCard: View {
    
    @State var isCategory: Bool = true
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(Color(hex: String.addBlue))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                Text((isCategory ? "Add Category" : "Add Action"))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .font(.system(size: 18.0, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: String.addBlue))
                    
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(lineWidth: 2.5).fill(Color(hex: String.addBlue)))
        .padding()
    }
}

struct NewCategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryCard(isCategory: true)
    }
}
