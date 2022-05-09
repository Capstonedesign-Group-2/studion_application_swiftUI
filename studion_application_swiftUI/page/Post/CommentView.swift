//
//  CommentView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/26.
//

import SwiftUI

struct CommentView: View {
    
    @State var hintText: String = "Comments"
    @State var content: String = ""
    
    var body: some View {
        ZStack{
            
            VStack{
                Text("This is Commentory system")
            }
            
            if content.isEmpty {
                Text(hintText)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $content)
                .frame(height: 30, alignment: .leading                      )
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
        }
        
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
