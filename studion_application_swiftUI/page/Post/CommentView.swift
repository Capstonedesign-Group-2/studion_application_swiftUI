//
//  CommentView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/26.
//

import SwiftUI

struct CommentView: View {
    
    @State var hintText: String = "This is input form"
    @State var content: String = ""
    
    var body: some View {
        ZStack{
            if content.isEmpty {
                Text(hintText)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $content)
                .frame(height: 600, alignment: .center)
        }
        
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
