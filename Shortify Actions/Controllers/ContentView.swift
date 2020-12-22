//
//  ContentView.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var isPresented: Bool = false
    @State var isActionPresented: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: FetchRequest<Category>
    
    var categories: FetchedResults<Category> { fetchRequest.wrappedValue }
    
    init() {
        fetchRequest = FetchRequest(entity: Category.entity(), sortDescriptors: [])
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: -15) {
                    ForEach(categories) { category in
                        NavigationLink(
                            destination: ActionList(uuid: category.id!, title: category.name),
                            label: {
                                CategoryCard(title: .constant(category.name), icon: .constant(category.icon), colorType: .constant(CustomColors(rawValue: category.colorType)!))
                            })
                    }
                    .listStyle(SidebarListStyle())
                    Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        NewCategoryCard(isCategory: true)
                            .frame(maxWidth: .infinity)
                    }).sheet(isPresented: $isPresented, content: {AddCategory(isPresented: $isPresented)})
                    
                }
            }
            .navigationBarTitle(Text("Shortify Actions"))
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: addCategoryButton())
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
    
    private func addCategoryButton() -> some View {
        var body: some View {
            Button(action: {
                self.isPresented.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }).sheet(isPresented: $isPresented, content: {AddCategory(isPresented: $isPresented)})
        }
        return body
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
