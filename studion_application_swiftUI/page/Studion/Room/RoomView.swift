//
//  RoomView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI
import SocketIO
import Alamofire
import CoreAudioTypes
import AVFoundation

struct RoomView: View {
    @Binding var pageStatus: String
    @Binding var mainRouter: String
    var roomNumber: Int
        
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    @State var getRoomNumber: Int = -1
    
    @ObservedObject var webRTCConnect = WebRTCConnect()
    
    var body: some View {
        InstrumentControllerView(mainRouter: $mainRouter, pageStatus: $pageStatus, dcDic: webRTCConnect.dcDic, pcDic: webRTCConnect.pcDic, userArray: webRTCConnect.userArray, nameDic: webRTCConnect.nameDic)
        .onAppear{
                getRoomNumber = roomNumber
                
                
                webRTCConnect.joinRoom(room: getRoomNumber)
                
//            do {
//                try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
//                try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
//            } catch {
//                print("error")
//            }
            
                
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                AppDelegate.orientationLock = .landscapeRight
            }
        
        .onDisappear{
            AppDelegate.orientationLock = .portrait
            print("room end")
            webRTCConnect.exitRoom()            
            
        }
        
    }
}




final class WebRTCConnect: ObservableObject {
    
    let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
    var webRTCClient: WebRTCClient? = WebRTCClient()
    
    @Published var pcDic: [String: Any] = [:]
    @Published var dcDic: [String: Any] = [:]
//    @Published var volumeDic: [String: Any] = [:]
    @Published var userArray: [String] = []
    @Published var nameDic: [String: String] = [:]

    
    init() {
        
        
        webRTCClient!.allUsers() {data in
            let response = data as! Dictionary<String, Any>
            
            DispatchQueue.main.async {
                self.pcDic = response["pcDic"] as! [String : Any]
                self.dcDic = response["dcDic"] as! [String : Any]
//                self.volumeDic = response["volumeDic"] as! [String: Any]
                self.userArray = response["userArray"] as! [String]
                self.nameDic = response["nameDic"] as! [String: String]
                
            }
            
        }
        webRTCClient!.getAnswer() {data in
            let response = data as! Dictionary<String, Any>
            DispatchQueue.main.async {
                self.pcDic = response["pcDic"] as! [String : Any]
                self.dcDic = response["dcDic"] as! [String : Any]
//                self.volumeDic = response["volumeDic"] as! [String: Any]
                self.userArray = response["userArray"] as! [String]
                self.nameDic = response["nameDic"] as! [String: String]
            }
        }
        webRTCClient!.getOffer() {data in
            let response = data as! Dictionary<String, Any>
            DispatchQueue.main.async {
                self.pcDic = response["pcDic"] as! [String : Any]
                self.dcDic = response["dcDic"] as! [String : Any]
//                self.volumeDic = response["volumeDic"] as! [String: Any]
                self.userArray = response["userArray"] as! [String]
                self.nameDic = response["nameDic"] as! [String: String]
            }
        }
        webRTCClient!.userExit() { data in
            let response = data as! Dictionary<String, Any>
            DispatchQueue.main.async {
                self.pcDic = response["pcDic"] as! [String : Any]
                self.dcDic = response["dcDic"] as! [String : Any]
//                self.volumeDic = response["volumeDic"] as! [String: Any]
                self.userArray = response["userArray"] as! [String]
                self.nameDic = response["nameDic"] as! [String: String]
            }
        }
        webRTCClient!.getCandidate() {data in
            let response = data as! Dictionary<String, Any>
            DispatchQueue.main.async {
                self.pcDic = response["pcDic"] as! [String : Any]
                self.dcDic = response["dcDic"] as! [String : Any]
//                self.volumeDic = response["volumeDic"] as! [String: Any]
                self.userArray = response["userArray"] as! [String]
                self.nameDic = response["nameDic"] as! [String: String]
            }
        }
        
        
        
    }
    
    func joinRoom(room: Int) {
        webRTCClient!.joinRoom(room: room)
    }
    
    func exitRoom() {
        webRTCClient!.exit()
        print("socket connected")
        socket.emit("exit_room")
        
        webRTCClient = nil
        print("room exit")
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
