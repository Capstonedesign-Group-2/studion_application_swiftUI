//
//  PostCard.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/01.
//

import SwiftUI
import UIKit
import AVKit
import URLImage
import AlertToast

struct PostCard: View {
    
    @Namespace var namespace
    @State var comment: Bool = false
    
    @State var title = ""
    @State var content = ""
    
    @State var id: Int?
    
    //image
    @State var image: String?
    
    //audio
    @State var audioURL: String?
    
//    @Binding var isDeleted: Bool
    
    var composers:[Any]?
    
    
    @State var userId: Int
    
    var body: some View {
            
        if UIDevice.isIpad {
            ZStack{
                VStack {
                    
                    //title
                    ZStack {
                        HStack {
                            Circle()
                                .fill(Color("mainDark2"))
                                .frame(width: 50, height: 50, alignment: .leading)
                                .background(Circle().stroke(Color.white, lineWidth: 5))
                                .overlay(
                                    Text(title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .lineLimit(0)
                                        .foregroundColor(.white)
                                    )
                                .clipped()
                                .padding(.all, 10)
                            
                            Text(title)
                                .foregroundColor(.black)
                                .font(.largeTitle.weight(.bold))
                                .matchedGeometryEffect(id: "title", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                        }// hS
                                    
                        Spacer()
                        VStack(alignment: .trailing) {
                            if (audioURL != nil) {
                                MenuView(audioURLString: audioURL!, postId: id, postUserId: userId, composers: composers)
                            } else {
                                MenuView(audioURLString: "", postId: id, postUserId: userId, composers: composers)
                            }
                        }// hS
                                  
                                            
                    }// zS (title)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                VStack {
                    if((image) != nil){
                        URLImage(url: URL(string: image!)!,
                                 content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        )

                        } else {
                            Image("Studion-original")
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 800, alignment: .center)
                                .padding()
                        }
                    }
                    
                    VStack {
                    Text(content)
                        .font(.title.weight(.bold))
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                    
                        VStack{
                            if (audioURL != nil) {
    //                          Text(audioURL!)
                                AudioView(audioURL: audioURL)
                                    .matchedGeometryEffect(id: "audio", in: namespace)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                            } else {
                                Text("No Audios...")
                            }
                        }
                        .padding(.bottom, 30)
                    
                    VStack {
                        Text("comments...")
                            .font(.body.weight(.semibold))
                            .matchedGeometryEffect(id: "comments", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.all, 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            ).onTapGesture {
                               comment = true
                            }
                                                
                    }//comments
                    .sheet(isPresented: $comment) {
                        CommentView(postId: id!)
                    }
                    
                } //vS
        
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(16.0)
                .shadow(color: .gray, radius: 2)
        
            } //zS
            .onTapGesture { // disable blank touch
                return
            }
            
            Spacer()

        } else { // iPhone
            
            ZStack {
                VStack() {
                    
                    //title
                    ZStack {
                        HStack {
                            Circle()
                                .fill(Color("mainDark2"))
                                .frame(width: 30, height: 30, alignment: .leading)
                                .background(Circle().stroke(Color.white, lineWidth: 5))
                                .overlay(
                                    Text(title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .lineLimit(0)
                                        .foregroundColor(.white)
                                    )
                                .clipped()
                                .padding(.all, 5)

                            
                            Text(title)
                                .font(.title.weight(.bold))
                                .matchedGeometryEffect(id: "title", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            
                        }// hS
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            if (audioURL != nil) {
                                MenuView(audioURLString: audioURL!, postId: id, postUserId: userId, composers: composers)
                                    .foregroundColor(Color("mainColor"))
                            } else {
                                MenuView(audioURLString: "", postId: id, postUserId: userId, composers: composers)
                            }
                        }// vS
                        
                    }// zS (title)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    
                VStack {
                    if((image) != nil){
                        URLImage(url: URL(string: image!)!,
                                 content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding()
//                                .shadow(color: .gray, radius: 5)
                            }
                        )

                        } else {
                            Image("Studion-original")
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 700, maxHeight: .infinity, alignment: .center)
//                                .shadow(color: .gray, radius: 5)
                                .padding()
                        }
                    }
                    
                    VStack {
                    Text(content)
                            .font(.title2.weight(.bold))
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                    
                        VStack{
                            if (audioURL != nil) {
    //                          Text(audioURL!)
                                AudioView(audioURL: audioURL, isPlaying: false)
                                    .matchedGeometryEffect(id: "audio", in: namespace)
                                    .frame(maxWidth: .infinity,minHeight: 50, alignment: .leading)
                                    .padding()
                            } else {
                                Text("No Audios...")
                            }
                        }
                        Spacer()
                        VStack {
                            Text("comments...")
                                .font(.body.weight(.semibold))
                                .matchedGeometryEffect(id: "comments", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.all, 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                ).onTapGesture {
                                    comment = true
                                }
                                                
                        }//comments
                            .sheet(isPresented: $comment) {
                                CommentView(postId: id!)
                            }
                    } //vS
        
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 1)
//                        .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0 , y: 0)
                )
                .cornerRadius(0)
                .shadow(color: .gray, radius: 2)
//                Spacer()
        
            } //zS
            .onTapGesture { // disable blank touch
                return
            }
            .onAppear{
//                print("A")
//                print(composers)
            }

        }// else
        
    }
}
    
//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "title", content: "content")
//    }
//}


struct MenuView: View {
    
    @State var audioURLString: String = ""
    
    @State var isActive: Bool = false
    @State var isDelete: Bool = false
    
    @State var isDeleted: Bool = false
    
    @State var postId: Int?
    
    @State var postUserId: Int
    @State var currentUserId = UserInfo.userInfo.user?.id
    
    var composers:[Any]?
    
    var body: some View {
        
        ZStack {
            VStack {
                Menu {
                    
                    if audioURLString != "" {
                        
                        Button(action: {
                            self.isActive = true
                        }, label: {
                                Text("録音リレー")
                                .font(.body).fontWeight(.semibold)
                            })
                    } else {// audioUrlCheck
                        Text("音楽ファイルがありません。")
                    }
                    
                    if postUserId == currentUserId {
                        Button(action: {
                            self.isDelete = true
                        }, label: {
                            Text("削除")
                                .foregroundColor(Color.red.opacity(0.5))
                        })
                    }
                    
                    } label: {
                            Label("", systemImage: "ellipsis")
                            .foregroundColor(Color.black)
                    }// menu
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .alert(isPresented: $isDelete) {
                        Alert(title: Text("削除"),
                                message: Text("本当ですか"),
                              primaryButton: .default (
                                {
                                    Text("いいえ")
                                }(), action: {
                                    self.isDelete = false
                                }),
                              secondaryButton: .destructive(
                                {
                                    Text("はい")
                                        .foregroundColor(.red.opacity(0.7))
                                }(), action: {
                                    delete()
                                        self.isDeleted.toggle()
                                })
                        )
                    }

                }// vS
        }
        
        NavigationLink(destination: RelayView(audioURLString: audioURLString, composers: composers), isActive: $isActive) {
            EmptyView()
        }// navLink
        .toast(isPresenting: $isDeleted) {
            AlertToast(type: .regular, title: "成功しました")
        }
        
    }// view
    
    func delete() {
        PostController.sharedInstance.delete(postId: postId!, userId: postUserId, handler: {_ in })
    }
}
