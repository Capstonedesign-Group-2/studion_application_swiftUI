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

