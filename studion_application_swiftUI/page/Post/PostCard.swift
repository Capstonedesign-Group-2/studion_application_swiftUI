//
//  PostCard.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/01.
//

import SwiftUI
import UIKit

struct PostCard: View {
    
    @State var title = ""
    @State var content = ""
    @State var image = ""
    
    var body: some View {
        VStack{
            Text(title)
                .padding()
            Text(content)
                .padding()
            Image(image)
        }
    }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}


//    .onAppear(perform: {
//        PostController.sharedInstance.show() {data in
////                print(data)
//
//            let response = data as! Dictionary<String, Any>
//
////                print(response)
//                let posts = response["posts"] as! Dictionary<String, Any>
//
//            p = posts["data"] as! Array<Dictionary<String, Any>?>
//
////                        let postId = posts["id"] as! Int
//
//            print("PostView: \(p)")
//
//
//            for post in p {
//
//                print("------------------------------------------------------")
//                if(post != nil) {
//                    let users = post!["user"] as! Dictionary<String, Any>
////                            print("user name : " + (users["name"] as! String))
//                    user = users["name"] as! String
//
//                    if(post!["image"] != nil) {
////                                print("image : " + (post!["image"] as! String))
//                    }
////                            print("post content : " + (post!["content"] as! String))
//                    content = post!["content"] as! String
//
//
//                    let audios = post!["audios"] as! Array<Dictionary<String, Any>?>
//                    if(audios.count != 0) {
//                        let audio = audios[0]
//                        print("audio : " + (audio!["link"] as! String))
//
//                    }
//
////                            print(postId)
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
//        }
//    })
//    .onDisappear{
//        print("PostView end")
////    }
