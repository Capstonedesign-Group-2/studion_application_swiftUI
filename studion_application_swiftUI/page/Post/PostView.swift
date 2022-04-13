//
//  PostView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/22.
//

import SwiftUI
import UIKit

struct PostView: View {
    
    @State var p: [Dictionary<String, Any>?] = []
    @State var currentPage: Int
    
    init() {
        if UIDevice.isIpad {
            // Disable Scrollbar
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
        currentPage = 1
    }
    
       var body: some View {
           
           if UIDevice.isIpad { // iPad
                              
               ZStack() {
                   
                    VStack {
                        
                        List {
                            ForEach(0..<self.p.count, id: \.self) { index in

                                var images = self.p[index]!["images"] as! [Dictionary<String, Any>?]
                                
                                    VStack{
                                        PostCard(
                                            title: self.p[index]!["title"] as! String, // Dict type on View
                                            content: self.p[index]!["content"] as! String,
                                            image: images[0]?["link"] as! String
                                        )
                                    Text("\(index)")
                                        .task(){
                                            print(index)
                                            if index % 8 == 7 {
                                                currentPage += 1
                                                print("currentPage : \(currentPage)")
                                            }
                                        }

                                }
                                }
                            } // list
                                    .padding(.horizontal, 150)
                        
                            } // vS
                            .onAppear {
                                PostController.sharedInstance.show(page: currentPage) { data in
//                                      print(data)
                                    let response = data as! Dictionary<String, Any>
//                                      print(response)
                                    let posts = response["posts"] as! Dictionary<String, Any>
                                    
//                                    var cpg = posts["current_page"] as! Int
//                                    cpg = page
                                           
                                    p = posts["data"] as! [Dictionary<String, Any>?]
                                    
                                    print("Posts Datas : \(p)")
//                                    print("current_page : \(page)")
                                }
                                
                            }.onDisappear() {
                                print("PostView end")
                            }
                            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                                Color.clear
                                    .background(.ultraThinMaterial)
                                    .frame(height: 50)
                            }

                        }

           } else { // iPhone
               
               ZStack {
//                   NavigationView{
                    VStack {
                        List {
                            ForEach(0..<self.p.count, id: \.self) { index in
                                VStack{
                                    var images = self.p[index]!["images"] as! [Dictionary<String, Any>?]
                                        PostCard(
                                            title: self.p[index]!["title"] as! String, // Dict type on View
                                            content: self.p[index]!["content"] as! String,
                                            image: images[0]?["link"] as! String
                                        )
                                    }
                                }
                            }
                            .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 50)
                                  .background(Material.bar)
                            }
                        }
                            NavigationBar(title: "Posts")


//                    .navigationTitle("Posts")
//                    .navigationBarTitleDisplayMode(.automatic)
//                   }.navigationViewStyle(StackNavigationViewStyle())

                                   .onAppear {
                                       PostController.sharedInstance.show(page: currentPage) { data in

                       //                          print(data)
                                               let response = data as! Dictionary<String, Any>
                       //                          print(response)
                                               let posts = response["posts"] as! Dictionary<String, Any>

                                               p = posts["data"] as! [Dictionary<String, Any>?]

                                               print("Posts Datas : \(p)")
//                                            print("current_page : \(page)")

                                   }
                               }
                                   .onDisappear{
                                       print("PostView end")
                                   }

                           }
               .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                   Color.clear
                       .frame(height: 50)
//                       .background(Material.bar)
               }

           } //else
    }
}


//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}

//          NavigationView{
//               List(0 ..< 30) { item in
//                   Text("Hello world!!!!")
//               }
//               .searchable(text: $text, placement:
//                    .navigationBarDrawer(displayMode: .always), prompt: Text("Search Anything"))
//
//               .navigationTitle("Posts")
//           }


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
//
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
//
//                print("**************************************************")
//            }
//
//
//
//
//        }
//    }
//    .onDisappear{
//        print("PostView end")
//    }
