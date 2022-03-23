//
//  RoomList.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import Foundation
import SocketIO

class RoomListController {
    
    
    func getRoomList() {
        let socket = SocketIO.sharedInstance.getSocket()
        
        socket.emit("get_room_list")
    }
}
