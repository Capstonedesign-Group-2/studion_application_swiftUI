//
//  CustomTabView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: String
    @Binding var showMenu: Bool

    var body: some View {
        
        VStack {
            HStack {
                
                Button {
                    
                } label : {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
            }
            .padding([.horizontal, .top])
            
            TabView(selection: $currentTab) {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.black
        )
    }
}
