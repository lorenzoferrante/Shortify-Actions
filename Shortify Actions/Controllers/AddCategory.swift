//
//  AddCategory.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import SwiftUI

class CategoryField: ObservableObject {
    @Published var name = "Insert Category Name"
    @Published var color: CustomColors = .Blue
    @Published var icon = ""
}

struct AddCategory: View {
    
    @Binding var isPresented: Bool
    
    @State private var selectedTag = 0
    
    let persistenceController = PersistenceController.shared
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    var grids: [GridItem] = Array(repeating: .init(.flexible()), count: 10)
    let numberOfColors = CustomColors.allCases
    
    @ObservedObject var categoryField = CategoryField()
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryCard(title: $categoryField.name,
                             icon: $categoryField.icon,
                             colorType: $categoryField.color)
                
                pickerView()
                
                if selectedTag == 0 {
                    nameTag()
                } else if selectedTag == 1 {
                    colorTag()
                } else if selectedTag == 2 {
                    iconTag()
                }

                Spacer()
            }
            .navigationBarItems(leading: doneButton(), trailing: cancelButton())
            .navigationTitle(Text("Add Category"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func pickerView() -> some View {
        var body: some View {
            Picker("Customize Category", selection: $selectedTag) {
                Text("Name").tag(0)
                Text("Color").tag(1)
                Text("Icon").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        return body
    }
    
    private func cancelButton() -> some View {
        var body: some View {
            Button(action: {
                self.$isPresented.wrappedValue.toggle()
            }, label: {
                Text("Cancel")
            })
        }
        return body
    }
    
    private func doneButton() -> some View {
        var body: some View {
            Button(action: {
                if (!["", "Category Name"].contains($categoryField.name.wrappedValue)) {
                    self.persistenceController.addNewCategory(category: categoryField)
                    self.$isPresented.wrappedValue.toggle()
                } else {
                    // Handle empty category name
                    print("Empty Category Name")
                }
            }, label: {
                Text("Done")
            })
        }
        return body
    }
    
    
    private func nameTag() -> some View {
        var body: some View {
            Group {
                VStack {
                    HStack {
                        Text("Category Name")
                            .font(.system(size: 20.0, weight: .bold, design: .rounded))
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.1))
                    
                    TextField("Insert name", text: $categoryField.name)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                }
            }
        }
        return body
    }
    
    
    private func colorTag() -> some View {
        var body: some View {
            VStack {
                HStack {
                    Text("Select Color")
                        .font(.system(size: 20.0, weight: .bold, design: .rounded))
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    Spacer()
                }
                .background(Color.gray.opacity(0.1))
                
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(numberOfColors) { color in
                            Button(action: {
                                $categoryField.color.wrappedValue = color
                                print($categoryField.color.wrappedValue)
                            }) {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.ivory.getColors(colorType: color)[0], Color.ivory.getColors(colorType: color)[1]]), startPoint: .top, endPoint: .bottom)))
                                    .overlay(
                                        Circle()
                                            .strokeBorder(
                                                Color.blueBottom,
                                                lineWidth: (color == $categoryField.color.wrappedValue ? 5 : 0)
                                            )
                                    )
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                }
            }
        }
        return body
    }
    
    private func iconTag() -> some View {
        let fontAwesomeSwiftUI = Font.custom("FontAwesome5Free-Regular", size: 20.0)
        let fontAwesome = UIFont(name: "FontAwesome5Free-Regular", size: 20.0)
        let fontDescriptor = fontAwesome!.fontDescriptor
        let characterSet : NSCharacterSet = fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.characterSet) as! NSCharacterSet
        
        var body: some View {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(characterSet.characters, id: \.self) { symbol in
                                    Button(action: {
                                        print(symbol)
                                        $categoryField.icon.wrappedValue = symbol
                                    }) {
                                        Text(symbol)
                                            .font(fontAwesomeSwiftUI)
                                            .imageScale(.large)
                                            .frame(width: 60, height: 60)
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .ignoresSafeArea(.all, edges: .bottom)
                        }
                    }
                }
            }
        }
        return body
    }
}

struct AddCategory_Previews: PreviewProvider {
    @State static var isShowing = true
    static var previews: some View {
        AddCategory(isPresented: $isShowing)
    }
 
}
