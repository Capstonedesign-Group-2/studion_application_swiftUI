//
//  CreateView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/25.
//

import SwiftUI

struct CreateView: View {
    
    @State var content: String = ""
    @State var image: String = ""
    @State var audio: String = ""
    @State var showDocPicker = false
    
    
    var body: some View {
        NavigationView() {
            Form {
                Section(header: Text("New Post")){
                    ZStack{
                        if content.isEmpty {
                            Text("This is input form")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        TextEditor(text: $content)
                    }
                    
                    Button("Pick Image or Audio"){
                        showDocPicker = true
                    }
                    .sheet(isPresented: self.$showDocPicker) {
//                        DocumentPicker(image: $image)
                    }
                    
                        Button(action: {
                            create(content: content)
                            content = ""
                        })
                        {
                        Text ("Submit")
                    }

                }
                
            }
            .navigationTitle("Create")
            .navigationBarTitleDisplayMode(.inline)
//            .background(NavigationBar(title: "Create"))
            
        }
        .navigationViewStyle(.stack)
    }
}

func create(content: String) {
    PostController.sharedInstance.create(content: content) {data in
        var response = data as! Dictionary<String, Any>
        
        if(response["status"] as! Int == 200) {
            print(response)
        } else {
            print("error")
        }
        
        print(response)
     }
}


struct CreateTitle: View {
    var body: some View{
        Text("Create")
            .font(.title)
            .fontWeight(.bold)
//            .padding(.bottom, 20)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
