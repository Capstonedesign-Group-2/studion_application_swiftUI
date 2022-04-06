//
//  GuitaView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct GuitarView: View {
    var body: some View {
        Text("gutiar")
            .onAppear{
                print("gutiar start")
            }
            .onDisappear{
                print("gutiar end")
            }
    }
}
