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
    
    var composers:[Any]?
    
    var body: some View {
            
        if UIDevice.isIpad {
            ZStack{
                VStack {
                    HStack {
                        ZStack {
                            Text(title)
                                .font(.largeTitle.weight(.bold))
                                .matchedGeometryEffect(id: "title", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.gray, lineWidth: 0.5)
                            )
                            MenuView(audioURLString: audioURL!, composers: composers)
                            
                        }
                    }
                    
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
            
            ZStack{
                VStack() {
                    HStack {
                        ZStack {
                            Text(title)
                                .font(.title.weight(.bold))
                                .matchedGeometryEffect(id: "title", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.gray, lineWidth: 0.5)
                            )
                            
                            MenuView(audioURLString: audioURL!, composers: composers)
                            
                        }
                    }
                    
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


