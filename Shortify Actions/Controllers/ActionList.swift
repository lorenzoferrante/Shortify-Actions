//
//  ActionList.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/14/20.
//

import SwiftUI
import CoreData

struct ActionList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var isPresented: Bool = false
    @State var isEditPresented: Bool = false
    
    @State var actionName: String = ""
    @State var actionLink: String = ""
    
    var fetchRequest: FetchRequest<Item>
    var categoryName: String
    var categoryID: UUID
    var items: FetchedResults<Item> { fetchRequest.wrappedValue }
    
    init(uuid: UUID, title: String) {
        categoryName = title
        categoryID = uuid
        print("ID: \(uuid)")
        fetchRequest = FetchRequest<Item>(entity: Item.entity(), sortDescriptors: [], predicate: NSPredicate(format: "category == %@", uuid as CVarArg))
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: -15) {
                ForEach(items, id: \.self) { item in
                    Link(destination: URL(string: item.link)!) {
                        ActionCard(title: .constant(item.title), editAction: {
                            self.$isEditPresented.wrappedValue.toggle()
                            actionName = item.title
                            actionLink = item.link
                            debug(el: item)
                        }).sheet(isPresented: $isEditPresented, content: {EditAction(actionName: actionName, actionURL: actionLink, isPresented: $isEditPresented)})
                    }
                }
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    NewCategoryCard(isCategory: false)
                        .frame(maxWidth: .infinity)
                }).sheet(isPresented: $isPresented, content: {AddAction(isPresented: $isPresented)})
            }
        }
        .navigationTitle(Text(categoryName))
        .navigationBarItems(trailing: addCategoryButton())
    }
    
    private func addCategoryButton() -> some View {
        var body: some View {
            Button(action: {
                self.isPresented.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }).sheet(isPresented: $isPresented, content: {AddAction(isPresented: $isPresented, categoryID: categoryID)})
        }
        return body
    }
    
    private func debug(el: Item) {
        print("[DEBUG] \(el.title) - \(el.link)")
    }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
//        Text("Ciao")
        ActionList(uuid: UUID(), title: "Prova")
    }
}
