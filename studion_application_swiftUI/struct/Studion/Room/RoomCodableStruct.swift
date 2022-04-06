//
//  RoomCodableStruct.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import Foundation

public class RoomCodableStruct {
    
    public struct roomsInfo: Codable {
            var rooms: [roomInfo]?
        }
        
        public struct roomInfo: Codable {
            var content: String
            var creater: Int
            var id: Int
            var locked: Int
            var max: Int
            var Password: String?
            var title: String
            var users: [userInfo]
        }
        
        public struct userInfo: Codable {
            var created_at: String
            var email: String
            var id: Int
            var image: String?
            var socket_id: String
            var updated_at: String
        }
}
