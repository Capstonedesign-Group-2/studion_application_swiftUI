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
    
    var body: some View {
            
        VStack(spacing: 20) {

            ZStack(alignment: .leading) {
                
//                Text(audioURL!)
                
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                Capsule().fill(Color.green).frame(width: self.width, height: 8)

            }.padding(.top)
            
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                
//                Button(action: {
//
//                    let increase = self.player.currentTime + 15
//
//                    if increase < self.player.duration {
//                        self.player.currentTime = increase
//                    }
//
//
//                    }, label: {
//                        Image(systemName: "goward.15.fill").font(.title)
//                    }
//                )
                
                Button(action: {
                    if self.isPlaying {
                        
                        player.pause()
                        self.isPlaying = false
                        
                    } else {
                        
                        player.play()
                        self.isPlaying = true

                    }
                    }, label: {
                        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill").font(.title)
                    }
                       
                       
                       
                )
                .onAppear() {
                        guard let url = URL(string: (audioURL)!) else {
                            print("wrong url")
                            return
                        }
                    
                            playerItem = AVPlayerItem(url: url)
                            player.replaceCurrentItem(with: playerItem)
                    
//                        var time = CMTimeGetSeconds(player.currentTime())
                    
//                            guard let duration = player.currentItem?.duration else { return }
//
//                            print("duration : \(duration)")
                    
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                            
                            var time = CMTimeGetSeconds(player.currentTime())
                            guard let duration = player.currentItem?.duration else { return }
                    
//                            print("duration : \(duration)")
                            
                            if isPlaying == true {
//                              print(self.player.currentTime) // time
                                            
//                                let screen = UIScreen.main.bounds.width - 30
//                                let value = CMTime(value: duration, timescale: CMTimeScale(time))
//                                print(type(of: duration))
//                                self.width = screen * CGFloat(value)
                       
                            }
                        }
                    
                    
                    
                }

                
//                Button(action: {
//
//                    self.player.currentTime -= 15
//
//                    }, label: {
//                        Image(systemName: "backward.15.fill").font(.title)
//                    }
//                )
                
                
                
            } // hS
            .padding(.top, 25)
            .foregroundColor(Color.black)
            
            
                
        } // zS
    } // vS
} // view



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
