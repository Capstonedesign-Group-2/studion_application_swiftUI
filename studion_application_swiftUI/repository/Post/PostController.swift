//
//  PostController.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/03/25.
//
import Foundation
import Alamofire
import SwiftUI

public class PostController {
    
    static let sharedInstance = PostController(api: ServerAdress.sharedInstance.getApiServerAdress())
    
    var api: String
    
    init(api: String) {
        self.api = api
    }
    
//****************************************************************************************************************
//    Create
//****************************************************************************************************************
    
    public func create(data: Dictionary<String, Any>, handler: @escaping (Any) -> Void) {
        
        let tokenController = JWTToken()
        let TOKEN:String? = tokenController.getToken()
        
        if (TOKEN != nil) {
            let url = api + "api/posts"
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(TOKEN!)",
                
            ]

        let parameter : [String: Any] = [
            "content": data["content"]!,
            "user_id": UserInfo.userInfo.user?.id,
        ]
            
            if(data["image"] != nil) {
                print("image type")
                print(type(of: data["image"]!))

            }
//
//            if(data["audio"] != nil) {
//                print("audio type")
//                print(URL.mimeType(data["audio"]! as! URL)())
//
//                let exname:String = ((data["audio"] as AnyObject).deletingPathExtension?.lastPathComponent)!
//                print(exname)
//            }
            
        
//
//         print("This is swift File \(parameter)")
//
//        AF.request(url, method: .post, parameters: parameter, headers: headers).responseData { response in
//            var status = response.response?.statusCode ?? 500
//            switch response.result{
//
//                //통신성공
//                case .success(let data):
//                if(status == 200){
//                    print("value: \(data) 통신 성공!!!!! Success!!")
//                }else {
//                    print(status)
//                }
//
//                //통신실패
//                case .failure(let error):
//                print("error: \(error)")
//            }
//        }
            
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameter {
                                if let temp = value as? String {
                                    multipartFormData.append(Data(temp.utf8), withName: key)
                                }
                                if let temp = value as? Int {
                                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                                }

                            }

                if(data["audio"] != nil) {

                    multipartFormData.append(data["audio"] as! Data, withName: "audio", fileName: (data["audioURL"]! as! URL).lastPathComponent, mimeType: URL.mimeType(data["audioURL"] as! URL)())
                }
                
                
                
                if(data["image"] != nil) {
                    let date:Date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateString:String = dateFormatter.string(from: date)
                    
                    multipartFormData.append(data["image"] as! Data, withName: "image", fileName: dateString, mimeType: "image/jpg")
                }
                
                
                
                

            }, to: url, headers: headers).responseJSON { (response) in
                print("upload")
                print(response)
            }
            
            
            
    } else {
            print("AA")
                
            let response_data : [String: Any] = [
                "status" : 401,
            ]
            handler(response_data)
    }
            
} // create
    
//****************************************************************************************************************
//    Show
//****************************************************************************************************************
    
    
    public func show(page: Int, handler: @escaping (Any) -> Void){
          let url = api + "api/posts?page=\(page)"
          
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
                          "data" : data,
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
    } // show
        
}


// ********************************************************************************
// 파일 url에서 타입 뽑기
// ********************************************************************************

import UniformTypeIdentifiers

extension NSURL {
    public func mimeType() -> String {
        if let pathExt = self.pathExtension,
            let mimeType = UTType(filenameExtension: pathExt)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}

extension URL {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}

extension NSString {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}

extension String {
    public func mimeType() -> String {
        return (self as NSString).mimeType()
    }
}
