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
    @State var value: Double = 0
    
    
    //time format
    @State var time: Double = 0
    @State var duration: Double = 0
    @State var cntTimeString = ""
    @State var durationString = ""
    
    var body: some View {
            
        GeometryReader { geometry in
        
            VStack(spacing: 10) {
                    
                ZStack(alignment: .leading) {
                    
    //                Text(audioURL!)
                    
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                    Capsule().fill(Color.green).frame(width: abs(self.width), height: 8)
                        .gesture(DragGesture()
                            .onChanged({ (value) in
                                let x = value.location.x

                                self.width = x

                            }).onEnded({ (value) in

                                let x = value.location.x

                                let screen = geometry.size.width - 30

                                let percent = x / screen
                                
                                time = Double(percent) * duration
                                
                                self.player.seek(to: CMTime(seconds: time, preferredTimescale: 600))
//                                print(time)

                            }))

                }
            
                HStack(spacing: geometry.size.width / 5 - 30) {
                    Text(cntTimeString)
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill").font(.title)
                    }).onTapGesture {
                        if self.isPlaying {
                            
                            player.pause()
                            self.isPlaying = false

                        } else {
                            
                            player.play()
                            self.isPlaying = true
                            
                        }
                    }// onTab (touch event for button)
                    
                    Spacer()
                    Text(durationString)
                
            } // hS
            .padding(.top)
            .foregroundColor(Color.black)
            
            } // vs
            .onAppear() {
                    guard let url = URL(string: (audioURL)!) else {
                        print("wrong url")
                        return
                    }
                        playerItem = AVPlayerItem(url: url)
                        player.replaceCurrentItem(with: playerItem)
                
                
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//                            print(audioURL)
                        
                        if isPlaying == true {
                            
                            let screen = geometry.size.width - 30
                            
                            time = CMTimeGetSeconds(player.currentTime())
                            
                            if time.isNaN || time.isInfinite || time == 0.0 {
                                return
                            } else { // time format
                                let totalCntTime = Int(time)
                                let tMin = totalCntTime / 60
                                let tSec = totalCntTime % 60
                                let tString = String(format: "%02d:%02d", tMin, tSec)
                                self.cntTimeString = tString
                            }
                            
                            duration = CMTimeGetSeconds(player.currentItem!.duration)
                            
                            if duration.isNaN || duration.isInfinite || duration == 0.0 {
                                return
                            } else {
                                let totalDuration = Int(duration)
                                let dMin = totalDuration / 60
                                let dSec = totalDuration % 60
                                let dString = String(format: "%02d:%02d", dMin, dSec)
                                self.durationString = dString
                            }
                            
                            value = time / duration
//                            self.width = screen * CGFloat(value)
                            
//                            print(screen)
//                            print("Value!!!!! : \(value)")
//                            print("Time!!!!!!! : \(round(time.value()))")
//                            print("Duration!!!!!!! : \(round(duration.value()))")

                                if value < 1 {
                                    self.width = screen * CGFloat(value)
                                } else {
                                    self.width = screen + 30
                                    isPlaying = false
                                }

                        } // time
                    }
                
                }// onAppear
                .onDisappear() {
                    self.time = 0
                    self.duration = 0
                    self.width = 0
                    self.durationString = ""
                    self.cntTimeString = ""
                    self.isPlaying = false
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                }
            
            
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
