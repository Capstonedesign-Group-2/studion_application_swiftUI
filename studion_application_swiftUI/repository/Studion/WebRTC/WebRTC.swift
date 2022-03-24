//
//  WebRTC.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import Foundation
import SocketIO
import WebRTC

class WebRTC {
    let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
    var pcDic: [String: RTCPeerConnection] = [:]
    var dcDic: [String: RTCDataChannel] = [:]
    var nameDic: [String: String] = [:]
    var webRTCDic: [String: WebRTCClient] = [:]
    
    
    func joinRoom(room: Int) {
        let userInfo = UserInfo()
        
        let user: AuthCodableStruct.userInfo = UserInfo.userInfo.getUserInfo()!
        
        let userData : [String: Any] = [
            "id" : user.id as Any,
            "name" : user.name as Any,
            "email" : user.email as Any,
            "image" : user.image as Any,
            "created_at" : user.created_at as Any,
            "updated_at" : user.updated_at as Any,
        ]
        let data : [String: Any] = [
            "room_id" : room,
            "user" : userData,
        ]
        print(2)
        socket.emit("join_room", data)
        
    }
    
    func allUsers() {
        socket.on("all_users") {data, ack in
            print("[room] allUsers")
            let users: [Any] = data[0] as! [NSDictionary]
            print(data)
            
            
            for user in users {
                
                print("for user in users")
                let userDictionary = user as! Dictionary<String, Any>
                
                let name = userDictionary["name"] as! String
                let socketID = userDictionary["id"] as! String
                
                let webRTCClient = WebRTCClient()
                
                webRTCClient.createPeerConnection(name: name, socketID: socketID)
                
                self.webRTCDic[socketID] = webRTCClient
            }
            
        }
    }
    
    
    func getAnswer() {
        for key in webRTCDic.keys {
            let webRTCClient = webRTCDic[key] as! WebRTCClient
            webRTCClient.getAnswer()
        }
    }
}
