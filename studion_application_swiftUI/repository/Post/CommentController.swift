//
//  CommentController.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/26.
//

import Foundation
import Alamofire
import SwiftUI

public class CommentController {
    static let sharedInstance = CommentController(api: ServerAdress.sharedInstance.getApiServerAdress())
    
    var api: String
    
    init(api: String) {
        self.api = api
    }
    
//****************************************************************************************************************
//    createComment
//****************************************************************************************************************
    
    public func createComment(data: Dictionary<String, Any>, handler: @escaping (Any) -> Void) {
        let tokenController = JWTToken()
        let TOKEN:String? = tokenController.getToken()
        
        if (TOKEN != nil) {
            let url = api + "api/comments"
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(TOKEN!)",
            ]
            
            let parameter : [String: Any] = [
                "content": data["content"]!,
                "user_id": UserInfo.userInfo.user?.id,
                "post_id": data["post_id"]
            ]
            
            
                    
            AF.request(url, method: .post, parameters: parameter, headers: headers).responseData { response in
                var status = response.response?.statusCode ?? 500
                switch response.result{
                            
                    //통신성공
                case .success(let data):
                    if(status == 200){
                        print("value: \(data) 통신 성공!!!!! Success!!")
                    }else {
                        print(status)
                    }
                      
                    //통신실패
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        } else {
            print("AA")
                
            let response_data : [String: Any] = [
                "status" : 401,
            ]
            handler(response_data)
    }
        
        
    } // create
    
}
