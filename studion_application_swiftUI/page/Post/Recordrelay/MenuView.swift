//
//  MenuView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/05/18.
//

import SwiftUI
import AudioKit

struct MenuView: View {
    
    var audioURLString: String
    
    @State var isActive: Bool = false
    @State var postId = 0
    
    @State var postUserId: Int
    @State var currentUserId = UserInfo.userInfo.user?.id
    
    var composers:[Any]?
    
    var body: some View {
        
        VStack {
            Menu {
                Button(action: {
                    self.isActive = true
                }, label: {
                        Text("Go to Recoding Relay")
                        .font(.body).fontWeight(.semibold)
                    })
                
                if postUserId == currentUserId {
                    Button(action: {
                        delete()
                    }) {
                        Text("Delete")
                            .foregroundColor(.orange.opacity(0.5))
                    }
                }
                
                } label: {
                        Label("", systemImage: "ellipsis")
                }// menu
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(Color.black)
            }// vS
            
        NavigationLink(destination: RelayView(audioURLString: audioURLString, composers: composers), isActive: $isActive) {
            EmptyView()
        }// navLink
    }
    
    func delete() {
        PostController.sharedInstance.delete(postId: postId, userId: postUserId) { response in
            
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
