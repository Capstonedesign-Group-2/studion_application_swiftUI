//
//  RoomCardView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI

struct RoomCardView: View {
    
    var roomInfo: RoomCodableStruct.roomInfo
    
    var color1 = Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235))
    var color2 = Color(#colorLiteral(red: 0.5897991657, green: 1, blue: 0.7255712152, alpha: 0.8470588235))
    
    var body: some View {

        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .top, endPoint: .bottomTrailing))
                .frame(width: 300, height: 200)
                .shadow(color: Color(#colorLiteral(red: 0.6251253486, green: 0.6654933095, blue: 0.6063877344, alpha: 0.8470588235)), radius: 25, x: -10, y: 10)
            
            ZStack {
                Circle().fill(Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)).opacity(0.3))
                    .frame(width: 50)
                
                Image(systemName: roomInfo.locked == 0 ? "lock.open" : "lock")
                    .resizable()
                    .frame(width:24, height: 24)
                    .foregroundColor(.white)
            }.offset(x: 100, y: -50)
            
            Text(roomInfo.title)
                .foregroundColor(.white)
                .bold()
                .font(.largeTitle)
                .offset(x: -100, y: -50)
            
            Text(roomInfo.content)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .font(.body)
                .offset(x: -100, y: -10)
            
            Text(String(roomInfo.users.count) + "/4")
                .foregroundColor(.white)
                .fontWeight(.medium)
                .font(.body)
                .offset(x: -100, y: 30)
            
        }
        .padding(.bottom, 10)
    }
}
