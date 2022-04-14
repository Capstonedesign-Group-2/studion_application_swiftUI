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
    @State var image: String?
    
    //audio
    @State var audioURL: String?
    
    
    var body: some View {
        ZStack{
            
            if !show {
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
                                .resizable().scaledToFit()
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
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()


                }

                
            } else {
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
                            .matchedGeometryEffect(id: "image", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .shadow(color: .gray, radius: 5)
                            .padding()
                    }
                    
                    Text(content)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
//                    AudioView(audioURL: "http://", audioTitle: "audio", playing: false)
//                        .matchedGeometryEffect(id: "content", in: namespace)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding()


                }
            }
        }
        
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }.transition(.slide)
    }
}


struct AudioView : View {
    
    @State var audioURL: String?
    @State var audioTitle: String = "No audio file..."
    @State var width: CGFloat = 0
//    @State var playWidth: CGFloat = 0
    @State var player: AVAudioPlayer!
    @State var playing: Bool = false
    
//    init() {
//        if UIDevice.isIpad{
//            playWidth = 400
//        } else {
//            playWidth = 200
//        }
//    }

    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(self.audioTitle).font(.title)
            
            ZStack(alignment: .leading) {
                
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8, alignment: .center)
                Capsule().fill(Color.green).frame(width: self.width, height: 8, alignment: .center)

            }.padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                
                Button(action: {
                    
//                    let increase = self.player.currentTime + 15
                    
                    
                    }, label: {
                        Image(systemName: "goward.15.fill").font(.title)
                    }
                )
                
                Button(action: {
                    if self.player.isPlaying {
                        
                        self.player?.pause()
                        self.playing = false
                        
                    } else {
                        
                        self.player?.play()
                        self.playing = true

                    }
                    }, label: {
                        Image(systemName: self.playing ? "pause.fill" : "play.fill").font(.title)
                    }
                )
                
                Button(action: {
                        //
                    }, label: {
                        Image(systemName: "backward.15.fill").font(.title)
                    }
                )
                
                
                
            } // hS
            .padding(.top, 25)
            .foregroundColor(Color.black)
            
            
                
        }.onAppear {
            
            let url = Bundle.main.path(forResource: "black", ofType: "mp3, wav")
            
            self.player = try! AVAudioPlayer(contentsOf: URL(string: (audioURL!))!)
            
            self.player.prepareToPlay()
            self.getAudioData()
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                
                if self.player.isPlaying {
//                    print(self.player.currentTime) // time
                    let screen = UIScreen.main.bounds.width - 30
                    
                    let value = self.player.currentTime / self.player.duration
                    
                    self.width = screen * CGFloat(value)
                }
            }
        }
    }
    
    func getAudioData() {

        let asset = AVAsset(url: self.player.url!)
        
        for a in asset.commonMetadata {
            if a.commonKey?.rawValue == "title" {
                let title = audioTitle
            }
        }
    }

}


//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard(title: "title", content: "content")
//    }
//}


