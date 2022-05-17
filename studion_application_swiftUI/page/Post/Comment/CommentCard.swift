//
//  CommentCard.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/05/12.
//

import SwiftUI

struct CommentCard: View {
    
    @State var pId: Int = 0
    @State var user: String?
    @State var content: String = ""
    
    var body: some View {
        
        HStack {
            VStack{
                Text(user!)
                    .font(.title3).fontWeight(.bold)
                    .padding(.horizontal, 50)
//                Spacer()
                Text(content)
                    .font(.body).fontWeight(.semibold)
                    .padding(.horizontal, 50)
            }
            .background(Color.white)
        }
    }
}

//struct CommentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCard()
//    }
//}
