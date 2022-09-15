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
    @Binding var c: Dictionary<String, Any>?
    
    @State var check = false
    
    var body: some View {
        
        HStack {
            HStack{
                if check {
                    VStack {
                        Circle()
                            .fill(Color("mainDark2"))
                            .frame(width: 50, height: 50, alignment: .leading)
                            .background(Circle().stroke(Color.white, lineWidth: 5))
                            .overlay(
                                Text(user!)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .lineLimit(0)
                                    .foregroundColor(.white)
                                )
                            .clipped()
                            .padding(.all, 5)

                    }.padding()
                    
                    VStack {
                        Text(user!)
                            .font(.title).fontWeight(.bold)
                            .padding(.horizontal, 30)
        //                Spacer()
                        Text(content)
                            .font(.title3).fontWeight(.semibold)
                            .padding(.horizontal, 30)
                    }
                    
                }
            }
            .frame(minWidth: 150, minHeight: 60, alignment: .leading)
            .background(Color.white)
        }.task() {
            let userArr = self.c!["user"] as! Dictionary<String, Any>
            user = userArr["name"] as? String
            content = c!["content"] as! String
            self.check = true
        }
        
    }
}

//struct CommentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCard()
//    }
//}
