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
    
    @State var getRoomNumber: Int = -1
    
    @ObservedObject var webRTCConnect = WebRTCConnect()
    
    var body: some View {
        Text("this is room " + String(getRoomNumber))
            .onAppear{
                getRoomNumber = roomNumber
                roomNumber = -1
                
                webRTCConnect.joinRoom(room: getRoomNumber)
            }
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
