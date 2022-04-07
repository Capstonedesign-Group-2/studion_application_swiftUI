//
//  PostView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/22.
//

import SwiftUI
import UIKit

struct PostView: View {
        
//    @State var posts = [PostsData]()
    
    @State var p: [Dictionary<String, Any>?] = []
        
       var body: some View {
           
            ZStack{
                VStack {
                    List {
                        ForEach(0..<self.p.count, id: \.self) { index in
                            VStack{
//                                Text(self.p[index]!["title"] as! String)
                                PostCard(title: self.p[index]!["title"] as! String, content: self.p[index]!["content"] as! String)
                            }
                        }
                    }
                    
                }
                NavigationBar(title: "Posts")
            }
           
            .task {
                PostController.sharedInstance.show() { data in
                    
//                          print(data)
                        let response = data as! Dictionary<String, Any>
//                          print(response)
                        let posts = response["posts"] as! Dictionary<String, Any>
                    
                        p = posts["data"] as! [Dictionary<String, Any>?]
            }
        }
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
