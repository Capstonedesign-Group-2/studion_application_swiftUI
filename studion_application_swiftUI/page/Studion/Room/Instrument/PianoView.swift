//
//  PianoView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI
import WebRTC

struct PianoView: View {
    var pcDic: [String: Any]
    
    var body: some View {
        Text("PianoView")
            .onAppear{
                print("piano start")
            }
            .onDisappear{
                print("piano end")
            }
    }
}


