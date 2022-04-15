//
//  RoomCardView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI

struct RoomCardView: View {
    
    var roomInfo: RoomCodableStruct.roomInfo
    
    var color2 = Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235))
//    var color2 = Color(#colorLiteral(red: 0.5897991657, green: 1, blue: 0.7255712152, alpha: 0.8470588235))
    var color1 = Color(red: 7/255, green: 85/255, blue: 59/255)
//    var color2 = Color(red: 7/255, green: 85/255, blue: 59/255)
    
    
    var width: CGFloat = 250
    var height: CGFloat = 20
    
//    var color3 =  Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//    var color4 = Color(#colorLiteral(red: 0, green: 0.6787529588, blue: 0, alpha: 1))
    var color3 = Color(red: 252/255, green: 246/255, blue: 245/255)
    var color4 = Color(red: 206/255, green: 212/255, blue:106/255)
    
    
    var body: some View {

        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .top, endPoint: .bottomTrailing))
                
                .frame(width: 300, height: 200)
                .shadow(color: Color(#colorLiteral(red: 0.6251253486, green: 0.6654933095, blue: 0.6063877344, alpha: 0.8470588235)), radius: 25, x: -10, y: 10)
            
            ZStack {
                Circle().fill(Color(#colorLiteral(red: 206/255, green: 212/255, blue:106/255, alpha: 0.8470588235)).opacity(0.3))
                    .frame(width: 50)
                
                Image(systemName: roomInfo.locked == 0 ? "lock.open" : "lock")
                    .resizable()
                    .frame(width:24, height: 24)
                    .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
            }.offset(x: 100, y: -50)
            
            Text(roomInfo.title)
                .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                .bold()
                .font(.largeTitle)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(width: 200,alignment: .topLeading)
                .offset(x: -25, y: -50)
            
            Text("参加者 : \(roomInfo.users.count) / 4")
                .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                .fontWeight(.medium)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(width: 200, alignment: .topLeading)
                .offset(x: -25, y: -10)
            
            
//            Text(String(roomInfo.users.count) + " / 4")
//                .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
//                .fontWeight(.medium)
//                .font(.body)
//                .frame(width: 200,alignment: .topLeading)
//                .offset(x: -25, y: 30)
            
            ZStack(alignment: .leading) {
                let multiplier = width / 4
                var percent: CGFloat = CGFloat(roomInfo.users.count)
                
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: width, height: height)
                    .foregroundColor(Color.black.opacity(0.1))
                
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: percent * multiplier, height: height)
                    .background(LinearGradient(gradient: Gradient(colors: [color3, color4]), startPoint: .leading, endPoint: .trailing)
                                    .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                    )
                    .foregroundColor(.clear)
            }
            .offset(x: -5, y: 30)
            
            
            
        }
        .padding(.bottom, 10)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
