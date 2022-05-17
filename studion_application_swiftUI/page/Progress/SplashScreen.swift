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
    
//    @State var status: Bool = false
    @State var loginStatus: Bool = false
    @State var mainStatus: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("Logo-1")
//                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                    NavigationLink(destination: LoginView(), isActive: $loginStatus ,label: {} )
                    .isDetailLink(false)
                    NavigationLink(destination: MainView(), isActive: $mainStatus ,label: {} )
                    .isDetailLink(false)
            }
            
            
            
        }   // NavigationView
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
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
            
            if(response["status"] as! Int == 401) {
                print("satus : logout")
                self.loginStatus = true
            } else if(response["status"] as! Int == 200) {
                print("status : login")
                print("22")
                self.mainStatus = true
            }
        
        }
        
        
    }
}
