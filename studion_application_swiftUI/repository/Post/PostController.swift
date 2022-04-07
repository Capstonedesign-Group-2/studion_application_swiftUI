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
    
//****************************************************************************************************************
//    Create
//****************************************************************************************************************
    
    public func create(content: String, handler: @escaping (Any) -> Void) {
        
        let tokenController = JWTToken()
        let TOKEN:String? = tokenController.getToken()
        
        if (TOKEN != nil) {
            let url = api + "api/posts"
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(TOKEN!)"
            ]

        let parameter : [String: Any] = [
            "content": content,
            "user_id": UserInfo.userInfo.user?.id,
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
    
    public func show(handler: @escaping (Any) -> Void){
          let url = api + "api/posts"
          
          AF.request(url, method: .get).responseJSON{ response in
              
              var status = response.response?.statusCode ?? 500
              
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
                          "status" : "Success",
                          "data" : data
                      ]
                      do{
                          handler(data)
                      } catch (let error) {
                          print(error)
                      }
                      
                    }
                  
//                  print("Xcode Data: \(data)")
                  
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
