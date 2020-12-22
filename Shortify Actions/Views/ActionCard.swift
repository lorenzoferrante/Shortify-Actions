//
//  ActionCard.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/14/20.
//

import SwiftUI

struct ActionCard: View {
    @Binding var title: String
    
    @State var editAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .font(.system(size: 18.0, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button {
                        editAction()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 14.0, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .background(Circle().fill(Color.primary.opacity(0.2)))
                    }
                }
                
                Text("Siri Shortcut not set")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .font(.system(size: 13.0, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                    
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Spacer()
        }
        .background(Color("ActionColor"))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(lineWidth: 0))
        .padding()
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

struct ActionCard_Previews: PreviewProvider {
    let fontAwesomeSwiftUI = Font.custom("FontAwesome5Free-Regular", size: 20.0)
    static var previews: some View {
        ActionCard(title: .constant("Crazy Action"), editAction: {
            print("Ciao")
        })
            
    }
}
