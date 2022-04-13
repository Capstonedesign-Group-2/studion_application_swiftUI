//
//  TTest.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/13.
//

import SwiftUI

struct TTest: View {
    var roomNumber: Int
    @State var test: Int = 1
    
    var body: some View {
        Text("Hello, World! : \(test)")
            .onAppear {
                self.test = self.test + 1
            }
    }
}

