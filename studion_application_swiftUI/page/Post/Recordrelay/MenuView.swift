////
////  MenuView.swift
////  studion_application_swiftUI
////
////  Created by Jinho Kim on 2022/05/18.
////
//
//import SwiftUI
//import AudioKit
//import AlertToast
//
//struct MenuView: View {
//    
//    @State var audioURLString: String = ""
//    
//    @State var isActive: Bool = false
//    @State var isDelete: Bool = false
//    
//    @State var isDeleted: Bool = false
//    
//    @State var postId: Int?
//    
//    @State var postUserId: Int
//    @State var currentUserId = UserInfo.userInfo.user?.id
//    
//    var composers:[Any]?
//    
//    var body: some View {
//        
//        VStack {
//            Menu {
//                
//                if audioURLString != "" {
//                    
//                    Button(action: {
//                        self.isActive = true
//                    }, label: {
//                            Text("録音リレー")
//                            .font(.body).fontWeight(.semibold)
//                        })
//                } else {// audioUrlCheck
//                    Text("音楽ファイルがありません。")
//                }
//                
//                if postUserId == currentUserId {
//                    Button(action: {
//                        self.isDelete = true
//                    }, label: {
//                        Text("削除")
//                            .foregroundColor(Color.red.opacity(0.5))
//                    })
//                }
//                
//                } label: {
//                        Label("", systemImage: "ellipsis")
//                        .foregroundColor(Color.black)
//                }// menu
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .alert(isPresented: $isDelete) {
//                    Alert(title: Text("削除"),
//                            message: Text("本当ですか"),
//                          primaryButton: .default (
//                            {
//                                Text("いいえ")
//                            }(), action: {
//                                self.isDelete = false
//                            }),
//                          secondaryButton: .destructive(
//                            {
//                                Text("はい")
//                                    .foregroundColor(.red.opacity(0.7))
//                            }(), action: {
//                                delete()
//                                    self.isDeleted.toggle()
//                            })
//                    )
//                }
//
//            }// vS
//        .toast(isPresenting: $isDeleted) {
//            AlertToast(displayMode: .alert, type: .complete(Color("mainColor")), title: "成功しました")
//        }
//        
//            
//        NavigationLink(destination: RelayView(audioURLString: audioURLString, composers: composers), isActive: $isActive) {
//            EmptyView()
//        }// navLink
//    }
//    
//    func delete() {
//        PostController.sharedInstance.delete(postId: postId!, userId: postUserId, handler: {_ in })
//    }
//}
//
////struct MenuView_Previews: PreviewProvider {
////    static var previews: some View {
////        MenuView()
////    }
////}
