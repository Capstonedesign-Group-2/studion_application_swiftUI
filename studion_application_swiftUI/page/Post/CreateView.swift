//
//  CreateView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/25.
//

import SwiftUI

struct CreateView: View {
    
    @State var hintText: String = "This is input form"
    @State var content: String = ""
    @State var image: Image?
    @State var audio: String = ""
    @State var showDocPicker = false
    
    @State var showingImagePicker = false
    @State var showingAudioPicker = false
    
    
    var body: some View {
        
        if UIDevice.isIpad {
            NavigationView() {
                
                
                ZStack {
//                    Color.black
//                        .opacity(0.05)
//                        .ignoresSafeArea()
                    
                    VStack {
                        Form {
                            Section(header: Text("New Post")){
                                ZStack{
                                    if content.isEmpty {
                                        Text(hintText)
                                            .foregroundColor(Color(UIColor.placeholderText))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 12)
                                    }
                                    TextEditor(text: $content)
                                }
                                
                                Button("Pick Image"){
//                                    showDocPicker = true
                                    showingImagePicker.toggle()
                                }
                                .sheet(isPresented: self.$showingImagePicker) {
            //                        DocumentPicker(image: $image)
                                    SUImagePicker(sourceType: .photoLibrary) { (image) in
                                        self.image = Image(uiImage: image)
                                        print(self.image)
                                    }
                                }
                                
                                Button("Pick Audio"){
//                                    showDocPicker = true
                                    showingImagePicker.toggle()
                                }
                                .fileImporter(isPresented: $showingAudioPicker, allowedContentTypes: [.audio], allowsMultipleSelection: false) {
                                    result in
                                    if case .success = result {
                                        do {
                                            print(try result.get().first)
                                            print(type(of: try result.get().first))
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                }
                                                                
                                
                                    Button(action: {
                                        if(checkText(content: content)){
                                            self.hintText = "무언가를 입력해주세요....."
                                        }
                                        create(content: content)
                                        content = ""
                                    })
                                    {
                                        Text("Submit")
                                    }

                            }
                            
                        }
                        .padding(.horizontal, 150)
                        
    //                    NavigationBar(title: "Create")

                    } // vS
                    .background(Color.clear)
                    .navigationTitle("Create")
                .navigationBarTitleDisplayMode(.inline)
                }
                
            }
            .navigationViewStyle(.stack)

            
        } else { //iPhone
            NavigationView() {
                Form {
                    Section(header: Text("New Post")){
                        ZStack{
                            if content.isEmpty {
                                Text(hintText)
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $content)
                        }
                        
                        Button("Pick Image"){
//                                    showDocPicker = true
                            showingImagePicker.toggle()
                        }
                        .sheet(isPresented: self.$showingImagePicker) {
    //                        DocumentPicker(image: $image)
                            SUImagePicker(sourceType: .photoLibrary) { (image) in
                                self.image = Image(uiImage: image)
                                print(self.image)
                            }
                        }
                        
                        Button("Pick Audio"){
//                                    showDocPicker = true
                            showingAudioPicker.toggle()
                            print(showingAudioPicker)
                        }
                        
                        
                            Button(action: {
                                if(checkText(content: content)){
                                    self.hintText = "무언가를 입력해주세요....."
                                }
                                create(content: content)
                                content = ""
                            })
                            {
                            Text("Submit")
                        }

                    }
                    
                }
                .navigationTitle("Create")
                .navigationBarTitleDisplayMode(.inline)
                //            .background(NavigationBar(title: "Create"))
                .fileImporter(isPresented: $showingAudioPicker, allowedContentTypes: [.audio], allowsMultipleSelection: false) {
                    result in
                    if case .success = result {
                        do {
                            print(try result.get().first)
                            print(type(of: try result.get().first))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                
            }
            .navigationViewStyle(.stack)
        }
        
        
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

func checkText(content: String) -> Bool {
    if(content == " " || content == ""){
        return true
    } else {
        return false
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

//struct DocummentPicker : UIViewControllerRepresentable {
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DocummentPicker>) ->
//    UIDocumentPickerViewController {
//
//    }
//}

//struct CreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateView()
//    }
//}
