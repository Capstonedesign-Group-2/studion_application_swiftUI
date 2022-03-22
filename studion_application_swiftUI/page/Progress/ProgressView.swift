//
//  ProgressView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
