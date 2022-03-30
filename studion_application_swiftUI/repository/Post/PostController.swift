//
//  PostController.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/25.
//
import Foundation
import Alamofire

public class PostController {
    
    static let sharedInstance = PostController(api: ServerAdress.sharedInstance.getApiServerAdress())
    
    var api: String
    
    init(api: String) {
        self.api = api
    }
    
    
//    public struct post: Codable {
//        var created_at: String!
//        var updated_at: String!
//        var title: String!
//        var id: Int!
//        var user_id: Int!
//        var content: String!
//        var image: String!
//        var audio: String!
//    }
    
//****************************************************************************************************************
//    Create
//****************************************************************************************************************
    
    public func create(content: String, user_id: Int, handler: @escaping (Any) -> Void) {
        
        let tokenController = JWTToken()
        let TOKEN:String? = tokenController.getToken()
        
        if (TOKEN != nil) {
            let url = api + "api/posts/create"
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(TOKEN!)"
            ]

        let parameter : [String: Any] = [
            "content": content,
            "user_id": user_id,
//            "image": image,
//            "audio": audio,
        ]
            
         print("This is swift File \(parameter)")
        
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
            
}
    
//****************************************************************************************************************
//    Read
//****************************************************************************************************************
    
    public func show(data: [String: Any], handler: @escaping (Any) -> Void){
        let url = api + "api/posts/show"
        
        let JWTTOKEN = "stadium_jwt_token"
        let TOKEN = UserDefaults.standard.string(forKey: JWTTOKEN)
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(TOKEN!)",
            "Content-Type":"application/json",
            "Accept":"application/json",
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON{ response in
            
            var status = response.response?.statusCode ?? 500
            
//            if let JSON = response.result.value {
//                print(JSON)
//            }
            
            switch response.result {
            case .success(let data):
                if(status == 401) {
                    let response_data: [String: Any] = [
                        "status" : 401,
                        "data" : data
                    ]
                    
                    handler(response_data)
                } else if (status == 200) {
                    let response_data: [String: Any] = [
                        "status" : 200,
                        "data" : data,
                    ]
                    
                    handler(response_data)
                }
                
                
//                print(status)
//
//                print("Xcode Data: \(data)")
                
            case .failure(let error):
                let response_data: [String: Any] = [
                    "status" : 500,
                    "error" : error
                ]
                print(error)
                
                handler(response_data)
            }

        }
    }
}
