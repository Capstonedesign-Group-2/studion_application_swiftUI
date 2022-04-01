//
//  PostView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI
import Foundation
import Alamofire

struct PostView: View {
    
    
    var body: some View {
        VStack{
            Text("posts")
        }
        .onAppear{
            print("dd")
            PostController.sharedInstance.show() {data in
//                print(data)
                let response = data as! Dictionary<String, Any>
//                print(response)
                let posts = response["posts"] as! Dictionary<String, Any>
                let p = posts["data"] as! Array<Dictionary<String, Any>?>
            
                for post in p {
                    
                    print("------------------------------------------------------")
                    if(post != nil) {
                        let user = post!["user"] as! Dictionary<String, Any>
                        print("user name : " + (user["name"] as! String))
                        if(post!["image"] != nil) {
                            print("image : " + (post!["image"] as! String))
                        }
                        
                        print("post content : " + (post!["content"] as! String))
                        
                        
                        let audios = post!["audios"] as! Array<Dictionary<String, Any>?>
                        if(audios.count != 0) {
                            let audio = audios[0]
                            print("audio : " + (audio!["link"] as! String))
                            
                        }
                        
                        
                        
                        let comments = post!["comments"] as! Dictionary<String, Any>
                        let comments_datas = comments["data"] as! Array<Dictionary<String,Any>?>
                        
                        for comments_data in comments_datas {
                            if(comments_data != nil) {
                                print("comments user_id : " + (comments_data!["user_id"] as! String))
                                print("comments content : " + (comments_data!["content"] as! String))
                            }
                        }
                    }
                    
                    print("**************************************************")
                }
                    
                    
                
                
            }
        }
        .onDisappear{
            print("PostView end")
        }
    }
}


//func show(content: String, title: String, handler: @escaping (Any) -> Void) {
//    PostController.sharedInstance.show(data: [:]) { data in
//        var response = data as! Dictionary<String, Any>
//        if(response["status"] as! Int == 200) {
//            AuthController.sharedInstance.loginCheck() {data in
//                handler(true)
//            }
//            print("This is PostView\(response)")
//
//        } else {
//            handler(false)
//        }
//    }
//}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}

