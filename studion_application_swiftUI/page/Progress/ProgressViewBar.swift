//
//  ProgressView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI

struct ProgressViewBar: View {
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percent: CGFloat = 69
    var color1 =  Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0, green: 0.6787529588, blue: 0, alpha: 1))
    
    var body: some View {
        
        let multiplier = width/100
        
        ZStack {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .background(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                )
                .foregroundColor(.clear)
        }
    }
}

struct ProgressViewBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewBar()
    }
}
