//
//  CreateView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/25.
//

import SwiftUI
import AVFoundation
import AlertToast

struct CreateView: View {
    
    @State var hintText: String = "入力フォーム"
    @State var content: String = ""
    @State var image: Data?
    @State var audio: Data?
    @State var audioURL: URL?
    @State var showDocPicker = false
    
    @State var showingImagePicker = false
    @State var showingAudioPicker = false
    
    @State var isCreated: Bool = false
    
    
    var body: some View {
        
        if UIDevice.isIpad {
            NavigationView() {
                ZStack {
                    VStack {
                        Form {
                            Section(header: Text("新しく作成")){
                                ZStack{
                                    if content.isEmpty {
                                        Text(hintText)
                                            .font(.largeTitle)
                                            .foregroundColor(Color(UIColor.placeholderText))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 12)
                                    }
                                    TextEditor(text: $content)
                                        .frame(height: 600, alignment: .center)
                                }
                                
                                Button(action: {
                                    showingImagePicker.toggle()
                                }) {
                                    Text("写真アップロード")
                                        .foregroundColor(Color("mainColor"))
                                }
                                
                                .sheet(isPresented: self.$showingImagePicker) {
            //                        DocumentPicker(image: $image)
                                    SUImagePicker(sourceType: .photoLibrary) { (image) in
        //                                self.image = Image(uiImage: image)
                                        print(image)
                                        print(type(of: image))
                                        self.image = image.jpegData(compressionQuality: 0.2)
                                    }
                                }
                                
                                Button(action: {
                                    showingAudioPicker.toggle()
                                    print(showingAudioPicker)
                                }) {
                                    Text("ミュージックアップロード")
                                        .foregroundColor(Color("mainColor"))
                                }
                                
                                
                                    Button(action: {
                                        if(checkText(content: content)){
                                            self.hintText = "文字を入力してください"
                                        } else {
                                            create()
                                            content = ""
                                            self.isCreated.toggle()
                                        }
                                    })
                                    {
                                    Text("登録")
                                        .foregroundColor(Color("mainColor"))
                                }
                            } // form
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 0.1)
//                                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0 , y: 0)
                            )
                            .cornerRadius(16.0)
//                            .shadow(color: .gray, radius: 2)
                            
                        }
//                        .padding(.horizontal, 130)

                    } // vS
                    
                    .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                        Color.clear
                            .frame(height: 45)
//                          .background(Material.bar)
                    }
                    
                    
//                    NavigationBar(title: "Create")
                    CreateTitle()
                        .ignoresSafeArea(edges: .all)
                    
                } // zS
                
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
//                .background(Color.clear)
//                .navigationBarTitleDisplayMode(.inline)
                
        
                .fileImporter(isPresented: $showingAudioPicker, allowedContentTypes: [.audio], allowsMultipleSelection: false) {
                    result in
                    if case .success = result {
                        do {
                            self.audioURL = try result.get().first!
                            print(result)
                            
                            if self.audioURL!.startAccessingSecurityScopedResource() {
                                self.audio = try Data(contentsOf: self.audioURL!)
                                defer { self.audioURL!.stopAccessingSecurityScopedResource() }
                            } else {
                                // Handle denied access
                                print("File Import Failed")
                            }
                                
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } //fileImporter
                

            } //nav
            .navigationViewStyle(StackNavigationViewStyle())
            .toast(isPresenting: $isCreated) {
                AlertToast(displayMode: .alert, type: .complete(Color("mainColor")), title: "成功しました")
            }



            
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
                                .frame(height: 300, alignment: .center)
                        }
                        
                        Button(action: {
                            showingImagePicker.toggle()
                        }) {
                            Text("Pick ImageFile")
                                .foregroundColor(Color("mainColor"))
                        }
                        
                        .sheet(isPresented: self.$showingImagePicker) {
    //                        DocumentPicker(image: $image)
                            SUImagePicker(sourceType: .photoLibrary) { (image) in
//                                self.image = Image(uiImage: image)
                                print(image)
                                print(type(of: image))
                                self.image = image.jpegData(compressionQuality: 0.2)
                            }
                        }
                        
                        Button(action: {
                            showingAudioPicker.toggle()
                            print(showingAudioPicker)
                        }) {
                            Text("Pick AudioFile")
                                .foregroundColor(Color("mainColor"))
                        }
                        
                        
                            Button(action: {
                                if(checkText(content: content)){
                                    self.hintText = "무언가를 입력해주세요....."
                                } else {
                                    create()
                                    content = ""
                                    self.isCreated.toggle()
                                }
                            })
                            {
                            Text("Submit")
                                .foregroundColor(Color("mainColor"))
                        }

                    }
//                    .navigationTitle("Create")
//                    .navigationBarTitleDisplayMode(.inline)
                }
                
//                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
//                    Color.clear
//                        .frame(height: 50)
//                      .background(Material.bar)
//                }
                //            .background(NavigationBar(title: "Create"))
                
                
                .fileImporter(isPresented: $showingAudioPicker, allowedContentTypes: [.audio], allowsMultipleSelection: false) {
                    result in
                    if case .success = result {
                        do {
                            self.audioURL = try result.get().first!
                            print(result)
                            
                            if self.audioURL!.startAccessingSecurityScopedResource() {
                                self.audio = try Data(contentsOf: self.audioURL!)
                                defer { self.audioURL!.stopAccessingSecurityScopedResource() }
                            } else {
                                // Handle denied access
                            }
                            
                            
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                NavigationBar(title: "Studion")
                
            }// navView
            .navigationViewStyle(.stack)
            .toast(isPresenting: $isCreated) {
                AlertToast(displayMode: .alert, type: .complete(Color("mainColor")), title: "成功しました")
            }

        }
        
        
    }
    
    
    
    func create() {
        
        var data: [String: Any] = [
            "content" : self.content,
        ]
        
        if(self.image != nil) {
            data["image"] = self.image
        }
        
        if(self.audio != nil) {
            data["audio"] = self.audio
            data["audioURL"] = self.audioURL
        }
        
        
        PostController.sharedInstance.create(data: data) {data in
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
}


struct CreateTitle: View {
    var body: some View{
        ZStack {
            Color("mainColor")
            
            Text("Create")
                .foregroundColor(.white)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
        }
        .ignoresSafeArea(edges: .all)
        
        
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .top)
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
