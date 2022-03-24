//
//  RoomView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI
import SocketIO
import Alamofire

struct RoomView: View {
    @Binding var pageStatus: String
    @Binding var roomNumber: Int
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    @State var getRoomNumber: Int = -1
    
    @ObservedObject var webRTCConnect = WebRTCConnect()
    
    var body: some View {
        InstrumentControllerView()
            .onAppear{
                getRoomNumber = roomNumber
                roomNumber = -1
                
                webRTCConnect.joinRoom(room: getRoomNumber)
                
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                AppDelegate.orientationLock = .landscapeRight
            }
            .onDisappear{ AppDelegate.orientationLock = .all }
    }
}




final class WebRTCConnect: ObservableObject {
    
    let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
    let webRTCClient: WebRTCClient = WebRTCClient()

    
    init() {
        
        webRTCClient.allUsers()
        webRTCClient.getAnswer()
        webRTCClient.getOffer()
        webRTCClient.userExit()
        webRTCClient.getCandidate()
        
        
        
    }
    
    func joinRoom(room: Int) {
        print(1)
        webRTCClient.joinRoom(room: room)
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
