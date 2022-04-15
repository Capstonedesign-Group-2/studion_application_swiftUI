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
    @State var show: Bool = false
    
    @State var title = ""
    @State var content = ""
    
    //image
    @State var image: String?
    
    //audio
    @State var audioURL: String?
    
    
    var body: some View {
        ZStack{
            
            if !show {
                
                VStack(spacing: 20) {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    if((image) != nil){
                        URLImage(url: URL(string: image!)!,
                                 content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .shadow(color: .gray, radius: 5)
                        }
                        )

                    } else {
                        Image("Studion-original")
                            .matchedGeometryEffect(id: "image", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .shadow(color: .gray, radius: 5)
                            .padding()
                    }
                    
                    Text(content)
                        .font(.title.weight(.bold))
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    if (audioURL != nil) {
//                        Text(audioURL!)
                        AudioView(audioURL: audioURL, isPlaying: false)
                            .matchedGeometryEffect(id: "audio", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    } else {
                        Text("No Audios...")
                    }
                    Spacer()


                }

                
            } else { // tap one
                
                VStack {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    if((image) != nil){
                        URLImage(url: URL(string: image!)!,
                                 content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: "image", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .shadow(color: .gray, radius: 5)
                        }
                        )

                    } else {
                        Image("Studion-original")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "image", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .shadow(color: .gray, radius: 5)
                    }
                    
                    Text(content)
                        .font(.title.weight(.bold))
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 30)
                        .padding(.leading, 30)
                    
                    AudioView(audioURL: audioURL, isPlaying: false)
                        .matchedGeometryEffect(id: "audio", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()


                }
            }
        }
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 0.1)
//                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0 , y: 0)
        )
        .cornerRadius(16.0)
        .shadow(color: .gray, radius: 2)
        Spacer()
        
//        .onTapGesture {
//            withAnimation {
//                show.toggle()
//            }
//        }.transition(.slide)
        
        
    } //zS
}





//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "title", content: "content")
//    }
//}


