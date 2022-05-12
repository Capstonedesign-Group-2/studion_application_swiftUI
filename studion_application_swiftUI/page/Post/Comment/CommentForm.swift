//
//  CommentForm.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/05/12.
//

import SwiftUI

struct CommentForm: View {
    
    @State var hintText: String = "Comments"
    @State var content: String = ""
    @State var postId: Int
    
    var body: some View {
            
        HStack{
//            HStack {
                TextField("\(hintText)", text: $content)
                .foregroundColor(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    Button(action: {
                        if(checkText(content: content)) {
                            self.hintText = "Something has need..."
                        }
                        write()
                        content = ""
                    }) {
                        Text("Write")
                            .foregroundColor(Color.black)
                    }
//                }
        }.padding(.all, 10)
        
    }
    
    func write() {
        var data: [String: Any] = [
            "content" : self.content,
            "postId": self.postId
        ]
        
        CommentController.sharedInstance.createComment(data: data) { data in
            var response = data as! Dictionary<String, Any>
            
            if response["Status"] as! Int == 200 {
                print(response)
            } else {
                print("Failed...")
            }
            
            print(response)
        }
    }
    
    func checkText(content: String) -> Bool {
        if(content == " " || content == ""){
            return true
        } else {
            return false
        }
    }
    
}


//struct CommentForm_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentForm()
//    }
//}
