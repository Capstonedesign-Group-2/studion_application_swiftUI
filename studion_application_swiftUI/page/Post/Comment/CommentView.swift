//
//  CommentView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/26.
//

import SwiftUI

struct CommentView: View {
    
    @State var postId: Int = 0
    @State var c: [Dictionary<String, Any>?] = []
    @State var empty: Bool = false
    @State var confirmRefresh = false
    
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                VStack{
                    
                    VStack {
                        
//                        if empty {
//                            VStack {
//                                Text("No Comments here....")
//                                    .font(.title)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                            }
//                            .background(Color.clear)
//
//                        } else {
                            VStack {
                                List {
                                    ForEach(0..<self.c.count, id: \.self){ comment in
                                        
                                        
//                                        let users = self.c[comment]?["user"] as! Dictionary<String, Any>?
                                        
                                        VStack {
                                            CommentCard(
                                                pId: postId,
                                                c: $c[comment]
//                                                user: users?.count == 0 ? nil : users?["name"] as? String,
//                                                content: self.c[comment]!["content"] as! String
                                            )
                                        }
                                    }// for
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                }// list
                                
                                .refreshable {
                                    c = []
                                    
                                    CommentController.sharedInstance.showComments(id: postId) { comment in
                                        let response = comment as! Dictionary<String, Any>
                //                                      print("RES : \(response)")
                                        
                                        let comments = response["comments"] as! Dictionary<String, Any>
                                        
                                        c += comments["data"] as! [Dictionary<String, Any>?]
                                        
                                    }
                               }
                                .onAppear() {
                                    CommentController.sharedInstance.showComments(id: postId) { comment in
                                        let response = comment as! Dictionary<String, Any>
                //                                      print("RES : \(response)")
                                        
                                        let comments = response["comments"] as! Dictionary<String, Any>
                                        
                                        c = comments["data"] as! [Dictionary<String, Any>?]
                                        
                                        if c.isEmpty {
                                            empty = true
                                            c = []
                                            print("no comments...")
                                        } else {
                                            print("Comments: \(c)")
                                        }
                                    }
                                }// onAppear
//                            }// else
                        }// vS
                    }// vS
                    Spacer()
                    VStack {
                        CommentForm(postId: postId, c: $c)
                            .foregroundColor(Color.white)
                    }//vS
                    
                }// vS
                    .background(Color.white)
//                    .frame(width: .infinity, height: 50, alignment: .topLeading)
                    .navigationBarTitle("Comments")
                    .navigationBarTitleDisplayMode(.inline)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }// zS
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
