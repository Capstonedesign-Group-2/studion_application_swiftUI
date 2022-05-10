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
        
        NavigationView {
            ZStack{
                ZStack{
                    if content.isEmpty {
                        Text(hintText)
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                    }
                    TextEditor(text: $content)
                        .frame(height: 50, alignment: .topLeading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                }
//                    .frame(width: .infinity, height: 50, alignment: .topLeading)
                    .navigationBarTitle("Comments")
                    .navigationBarTitleDisplayMode(.inline)
            }// zS
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
