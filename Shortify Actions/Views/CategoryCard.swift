//
//  CategoryCard.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import SwiftUI

struct CategoryCard: View {
    
    @Binding var title: String
    @Binding var icon: String
    @Binding var colorType: CustomColors
    
    var body: some View {
        
        let fontAwesomeSwiftUI = Font.custom("FontAwesome5Free-Regular", size: 20.0)
        let colors: [Color] = Color.orange.getColors(colorType: colorType)
        
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(icon)
                        .font(fontAwesomeSwiftUI)
                        .foregroundColor((colorType == CustomColors.White ? .black : .white))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    
                    Spacer()
                    
                    Text("\(Int.random(in: 1...20)) items")
                        .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                        .foregroundColor((colorType == CustomColors.White ? .black : .white))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(RoundedRectangle(cornerRadius: 10).inset(by: 5.0).fill((colorType == CustomColors.White ? Color.black.opacity(0.1) : Color.black.opacity(0.3)))
                )}
                
                Text(title)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .font(.system(size: 18.0, weight: .bold, design: .rounded))
                    .foregroundColor((colorType == CustomColors.White ? .black : .white))
                    
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [colors[0], colors[1]]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0))
        .padding()
        .shadow(color: Color.black.opacity(0.25), radius: 7, x: 0, y: 0)
    }
    
}


struct CategoryCard_Previews: PreviewProvider {
    let fontAwesomeSwiftUI = Font.custom("FontAwesome5Free-Regular", size: 20.0)
    static var previews: some View {
        CategoryCard(title: .constant("New Category"), icon: .constant(""), colorType: .constant(.Blue))
    }
}
