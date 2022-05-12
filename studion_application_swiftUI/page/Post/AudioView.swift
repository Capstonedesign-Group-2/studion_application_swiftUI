//
//  AudioView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/15.
//

import SwiftUI
import AVKit

struct AudioView : View {
    
    @State var audioURL: String?
    @State var width: CGFloat = 0
    @State var player = AVPlayer()
    @State var playerItem: AVPlayerItem?
    @State var isPlaying: Bool = false
    @State var isEnded: Bool = false
    
    var body: some View {
            
        GeometryReader { geometry in
        
            VStack(spacing: 10) {
                    
                ZStack(alignment: .leading) {
                    
    //                Text(audioURL!)
                    
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                    Capsule().fill(Color.green).frame(width: self.width, height: 8)

                }
            
                HStack(spacing: geometry.size.width / 5 - 30) {
                
                
                    Button(action: {}, label: {
                        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill").font(.title)
                    }).onTapGesture {
                        if self.isPlaying {
                            
                            player.pause()
                            self.isPlaying = false
                            
                        } else if isEnded {
                            isEnded = false
                            player.play()
                            self.isPlaying = true

                        } else {
                            player.play()
                            self.isPlaying = true
                        }
                    }// onTab (touch event for button)
                
            } // hS
            .padding(.top)
            .foregroundColor(Color.black)
            .task() {
                    guard let url = URL(string: (audioURL)!) else {
                        print("wrong url")
                        return
                    }
                    if isEnded {
                        playerItem = nil
                        player.replaceCurrentItem(with: playerItem)
                    } else {
                        playerItem = AVPlayerItem(url: url)
                        player.replaceCurrentItem(with: playerItem)
                    }
                
                
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//                            print(audioURL)
                        
                        if isPlaying == true {
        
                            let time = CMTimeGetSeconds(player.currentTime())
                            let duration = CMTimeGetSeconds(player.currentItem!.duration)
                            let floatDuration = Float64(duration)
                            
                            let screen = geometry.size.width - 30
                            let value = time / floatDuration
                            
                            
                            print(screen)
                            
                                if value < 1 {
                                    self.width = screen * CGFloat(value)
                                } else {
                                    self.width = screen + 30
                                    isEnded = true
                                    isPlaying = false
                                }
                            
                            print("Value!!!!! : \(value)")
                            print("Time!!!!!!! : \(time)")
                            print("Duration!!!!!!! : \(duration)")

                        }
                    }
                
                }// task
        
            } // vs
            
        }.frame(maxWidth: .infinity, maxHeight: 30, alignment: .center) // geometry
            .padding(.bottom, 10)
        
    }// view
}



//struct AudioView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioView()
//    }
//}


//            .task {
//
//                guard let url = URL(string: audioURL!) else {
//                    print("no audio...")
//                    return
//                }
//
//                self.player.prepareToPlay()
//                self.getAudioData()
//
//                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//
//                    if self.player.isPlaying {
//    //                    print(self.player.currentTime) // time
//                        let screen = UIScreen.main.bounds.width - 30
//
//                        let value = self.player.currentTime / self.player.duration
//
//                        self.width = screen * CGFloat(value)
//                    }
//                }
//            }

//    func getAudioData() {
//
//        let asset = AVAsset(url: self.player.url!)
//
//    }
