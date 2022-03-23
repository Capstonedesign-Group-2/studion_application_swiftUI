//
//  Splash Screen.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI
import SocketIO
import WebRTC

struct SplashScreen: View {
    @Binding var pageStatus: String
    
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear{ initSetting() }
    }
    
    func initSetting() {
        self.socketInit()
        self.loginCheckInit()
    }
    
    func socketInit() {
        SocketIO.sharedInstance.establishConnection()
        let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
    }
    
    func loginCheckInit() {
        
        
        AuthController.sharedInstance.loginCheck() { data in
            print("logincheck")
            let response = data as! Dictionary<String, Any>
            print(response)
            if(response["status"] as! Int == 401) {
                print("satus : logout")
                self.pageStatus = "/login"
            } else if(response["status"] as! Int == 200) {
                print("status : login")
                self.pageStatus = "/"
            }
        
        }
        
        
    }
}
