//
//  ChatRoomList.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI

struct ChatRoomList: View {
    var body: some View {
        
        if UIDevice.isIpad {
            
            VStack {
                Text("Chat Room for iPad")
            }
            .padding(.horizontal, 150)
            
        } else {
            VStack {
                Text("Chat room list")
            }
            .padding(.horizontal, 1)
        }
    
    }
}
