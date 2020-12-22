//
//  AddAction.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/15/20.
//

import SwiftUI
import CoreData

class ActionField: ObservableObject {
    @Published var title = ""
    @Published var link = ""
    @Published var category: UUID?
    @Published var id: UUID?
}

struct AddAction: View {
    
    let persistenceController = PersistenceController.shared
    
    @Binding var isPresented: Bool
    
    @State var categoryID: UUID?
    @State var actionName: String = ""
    @State var actionURL: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Inert name", text: $actionName)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("URL")
                        Spacer()
                        TextField("Inert link URL", text: $actionURL)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    addSiriButton()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(leading: doneButton(), trailing: cancelButton())
            .navigationTitle(Text("Add Action"))
            .navigationBarTitleDisplayMode(.inline)
        }
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
                if ("" != $actionName.wrappedValue) {
                    if ("" != $actionURL.wrappedValue) {
                        let newAction = ActionField()
                        newAction.id = UUID()
                        newAction.title = $actionName.wrappedValue
                        newAction.link = $actionURL.wrappedValue
                        newAction.category = $categoryID.wrappedValue
                        
                        persistenceController.addNewAction(action: newAction)
                        
                        self.$isPresented.wrappedValue.toggle()
                    }
                }
            }, label: {
                Text("Done")
            })
        }
        return body
    }
    
    private func addSiriButton() -> some View {
        var body: some View {
            Button(action: {}) {
                Text("Add Siri Shortcut")
            }
        }
        return body
    }
}

struct AddAction_Previews: PreviewProvider {
    static var previews: some View {
        AddAction(isPresented: .constant(true))
    }
}
