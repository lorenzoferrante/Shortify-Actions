//
//  EditAction.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/16/20.
//

import SwiftUI
import CoreData

struct EditAction: View {
    
    let persistenceController = PersistenceController.shared
    
    @State var actionName: String = ""
    @State var actionURL: String = ""
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section{
                    if ($actionURL.wrappedValue.isValidURL) {
                        URLPreview(previewURL: URL(string: $actionURL.wrappedValue)!)
                            .aspectRatio(contentMode: .fill)
                    } else {
                        noPreviewView()
                    }
                }
                .multilineTextAlignment(.center)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
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
                    deleteAction()
                        .multilineTextAlignment(.center)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(leading: doneButton(), trailing: cancelButton())
            .navigationTitle(Text("Add Action"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func noPreviewView() -> some View {
        var body: some View {
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title)
                        .imageScale(.large)
                        .foregroundColor(.redBottom)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    Text("No preview available".uppercased())
                        .font(.system(size: 15.0, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding()
                }
                Spacer()
            }
            .aspectRatio(contentMode: .fill)
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
                if ("" != $actionName.wrappedValue) {
                    if ("" != $actionURL.wrappedValue) {
                        let newAction = ActionField()
                        newAction.id = UUID()
                        newAction.title = $actionName.wrappedValue
                        newAction.link = $actionURL.wrappedValue
                        newAction.category = UUID()
                        
                        persistenceController.editAction(action: newAction)
                        
                        self.$isPresented.wrappedValue.toggle()
                    }
                }
            }, label: {
                Text("Done")
            })
        }
        return body
    }
    
    private func deleteAction() -> some View {
        var body: some View {
            Button(action: {}) {
                Text("Delete Action")
                    .foregroundColor(Color.red)
            }
        }
        return body
    }
        
}

struct EditAction_Previews: PreviewProvider {
    static var previews: some View {
        EditAction(isPresented: .constant(true))
    }
}
