//
//  LeftBarView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct LeftBarView: View {
    
    
    var body: some View {
        VStack {
            HStack {
                Text("helloooooooooooooooooo this is left bar")
                    .background( Color.white )
                Spacer()
            }
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.height * 3/4)
        .background( Color.yellow )
        
            
    }
}



