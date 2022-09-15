//  PostView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/22.
//

import SwiftUI
import UIKit

struct PostView: View {
    
    @State var p: [Dictionary<String, Any>?] = []
    @State var currentPage: Int = 0
    @State var lastPage: Int = 0
    
    init() {
        if UIDevice.isIpad {
            // Disable Scrollbar
            UITableView.appearance().showsVerticalScrollIndicator = false
        } else {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    }
    
       var body: some View {
           
           
           if UIDevice.isIpad { // iPad
                              
               ZStack {
                    VStack {
                        List {
                            ForEach(0..<p.count, id: \.self) { index in
                                
                                let images = self.p[index]?["images"] as! [Dictionary<String, Any>?]
                                let audios = self.p[index]?["audios"] as! [Dictionary<String, Any>?]
                                
                                let audio = audios.count == 0 ? nil : (audios[0] as! Dictionary<String, Any>)
                                let composers = audio == nil ? nil : audio!["composers"] as? [Any]
                                
                                
//                                let image = images.map{ $0 }
                                
//                                Button(action: {
//                                    print(audios)
//                                }, label: {
//                                    Text("button1")
//                                })
                                
                                LazyVStack {
                                    PostCard(
                                            title: self.p[index]!["title"] as! String, // Dict type on View
                                            content: self.p[index]!["content"] as! String,
                                            id: self.p[index]?["id"] as? Int,
                                            image: images.count == 0 ? nil : images[0]?["link"] as? String,
                                            audioURL: audios.count == 0 ? nil : audios[0]?["link"] as? String,
                                            composers: composers,
                                            userId: self.p[index]!["user_id"] as! Int
                                        )
                                    } //vS
                                    
                                .onAppear() {
//                                    print("index : \(index % 8)")
                                    if index % 8 == 7 {
                                        if currentPage == lastPage {
                                            currentPage = lastPage
                                            return
                                        } else {
                                            currentPage += 1
                                        }
                                        
                                        print("currentPage : \(currentPage)")
                                        print("lastPage : \(lastPage)")
                                        
                                        PostController.sharedInstance.show(page: currentPage) { data in
                                            let response = data as! Dictionary<String, Any>

                                            let posts = response["posts"] as! Dictionary<String, Any>
                                            
                                            p += posts["data"] as! [Dictionary<String, Any>?]
                                        }
                                        
                                    }
                                    
                                } // onAppear
                                
                                } // ForEach
                            
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 20, trailing: 1))
                            
                            } // list
                        
                        
                                .padding(.horizontal, 100)
                                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                                    NavigationBar(title: "サウンドくも")
                                        .frame(height: 50)
                                        .background(Color("mainColor"))
//                                    Color.clear
//                                        .frame(height: 50)
//                                        .background(Color.white)
                                }
                        
                                .refreshable {
                                    currentPage = 1
                                    p = []
                                    
                                    PostController.sharedInstance.show(page: currentPage) { data in
                                        let response = data as! Dictionary<String, Any>

                                        let posts = response["posts"] as! Dictionary<String, Any>
                                        
                                        p = posts["data"] as! [Dictionary<String, Any>?]
                                    }
                               }
                            } // vS
                                
                            .onAppear() {
                                PostController.sharedInstance.show(page: currentPage) { data in
//                                      print(data)
                                    let response = data as! Dictionary<String, Any>
//                                      print("RES : \(response)")
                                    
                                    let posts = response["posts"] as! Dictionary<String, Any>
                                    
                                    currentPage = posts["current_page"] as! Int
                                    lastPage = posts["last_page"] as! Int
                                    print("current : \(currentPage) : last \(lastPage)")
                                    
                                    p = posts["data"] as! [Dictionary<String, Any>?]
                                                                      
                                    print("Posts Datas : \(p)")
                                    
                                }
                                
                            }
                            .onDisappear() {
                                print("PostView end")
                                currentPage = 1
                                p = []
                            }
                        
                   
                    .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                        Color.clear
                            .background(.ultraThinMaterial)
                            .frame(height: 50)
                    }
                   
               }// zS
               

           } else { // iPhone
               
               ZStack {
//                   NavigationView{
                   VStack {
                        List {
                            ForEach(0..<self.p.count, id: \.self) { index in

                                let images = self.p[index]?["images"] as! [Dictionary<String, Any>?]
                                let audios = self.p[index]?["audios"] as! [Dictionary<String, Any>?]
//                                let composers = audios["composers"] as? [Any]

                                let audio = audios.count == 0 ? nil : (audios[0] as! Dictionary<String, Any>)
                                let composers = audio == nil ? nil : audio!["composers"] as? [Any]
                                    
                                LazyVStack {
                                    PostCard(
                                            title: self.p[index]!["title"] as! String, // Dict type on View
                                            content: self.p[index]!["content"] as! String,
                                            id: self.p[index]?["id"] as? Int,
                                            image: images.count == 0 ? nil : images[0]?["link"] as? String,
                                            audioURL: audios.count == 0 ? nil : audios[0]?["link"] as? String,
                                            composers: composers,
                                            userId: self.p[index]!["user_id"] as! Int
                                        )
                                    } //vS
                                    
                                .onAppear() {
//                                    print("index : \(index % 8)")
                                    if index % 8 == 7 {
                                        if currentPage == lastPage {
                                            currentPage = lastPage
                                            return
                                        } else {
                                            currentPage += 1
                                        }
                                        
                                        print("currentPage : \(currentPage)")
                                        
                                        PostController.sharedInstance.show(page: currentPage) { data in
                                            let response = data as! Dictionary<String, Any>

                                            let posts = response["posts"] as! Dictionary<String, Any>
                                            
                                            p += posts["data"] as! [Dictionary<String, Any>?]
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
//                                    print(p[index])
                                    
                                } // onAppear
                                
                            }// foreach
                            .listRowBackground(Color.white)
                            .listRowSeparator(.hidden)
//                            .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        }// list
   
                       
                            .refreshable {
                                currentPage = 1
                                p = []
                                
                                PostController.sharedInstance.show(page: currentPage) { data in
                                    let response = data as! Dictionary<String, Any>

                                    let posts = response["posts"] as! Dictionary<String, Any>
                                    
                                    p = posts["data"] as! [Dictionary<String, Any>?]
                                }
                           }
                       
                            .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 50)
                                  .background(Material.bar)
                            }
                        } // vS


//                    .navigationTitle("Posts")
//                    .navigationBarTitleDisplayMode(.automatic)
//                   }.navigationViewStyle(StackNavigationViewStyle())

                                
                       .onAppear {
                                       
                           PostController.sharedInstance.show(page: currentPage) { data in

//                          print(data)
                               let response = data as! Dictionary<String, Any>
//                          print(response)
                               let posts = response["posts"] as! Dictionary<String, Any>
                                        
                               currentPage = posts["current_page"] as! Int
                               lastPage = posts["last_page"] as! Int
                                        
                               p = posts["data"] as! [Dictionary<String, Any>?]

//                               print("post")
//                               print(p[0])
                           }
                               
                       }
                                   
                       .onDisappear{
                           print("PostView end")
                           currentPage = 1
                           p = []
                       }
        
               } // zS
               
                   NavigationBar(title: "サウンドクモ")
                       .background(Color("mainColor"))
               
                        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                            Color.clear
                                .frame(height: 50)
//                          .background(Material.bar)
                        }

        
           } //else
       }
} // view


//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}


//    .onAppear{
//        PostController.sharedInstance.show() { data in
////                print(data)
//            @State var response = data as! Dictionary<String, Any>
////                print(response)
//            @State var posts = response["posts"] as! Dictionary<String, Any>
//            @State var p = posts["data"] as! Array<Dictionary<String, Any>?>
//
//            for post in p {
//
//                print("------------------------------------------------------")
//                if(post != nil) {
//                    @State var user = post!["user"] as! Dictionary<String, Any>
////                        print("user name : " + (user["name"] as! String))
//                    userName = user["name"] as! String
//
////                        if(post!["image"] != nil) {
////                            print("image : " + (post!["image"] as! String))
////                        }
//
//                    print("post content : " + (post!["content"] as! String))
//                    content = post!["content"] as! String
//
//                    print(post!["id"] as! Int)
//
//                    let audios = post!["audios"] as! Array<Dictionary<String, Any>?>
//                    if(audios.count != 0) {
//                        let audio = audios[0]
//                        print("audio : " + (audio!["link"] as! String))
//
//                    }
//
//                    let comments = post!["comments"] as! Dictionary<String, Any>
//                    let comments_datas = comments["data"] as! Array<Dictionary<String,Any>?>
//
//                    for comments_data in comments_datas {
//                        if(comments_data != nil) {
//                            print("comments user_id : " + (comments_data!["user_id"] as! String))
//                            print("comments content : " + (comments_data!["content"] as! String))
//                        }
//                    }
//                }
//                print("**************************************************")
//            }
//        }
//    }
//    .onDisappear{
//        print("PostView end")
//    }
