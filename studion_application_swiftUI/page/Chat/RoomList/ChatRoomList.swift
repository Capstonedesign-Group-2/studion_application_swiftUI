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
            NavigationView {
                ZStack {
                    VStack {
                        Text("ブレンド")
                            .font(.title).fontWeight(.semibold)
                            .foregroundColor(Color("mainColor"))
                    }
                    NavigationBar(title: "チャット")
                        .edgesIgnoringSafeArea(.top)
                }
                

                    Text("今は静かですね")
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(Color("mainColor"))
                
                
//                .padding(.horizontal, 150)
            }.navigationViewStyle(DoubleColumnNavigationViewStyle())
            
            
        } else {
            VStack {
                Text("Chat room list")
            }
            .padding(.horizontal, 1)
        }
    
    }
}
