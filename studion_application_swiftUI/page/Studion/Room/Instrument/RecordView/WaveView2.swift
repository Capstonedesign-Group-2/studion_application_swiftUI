//
//  WaveView2.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/05/06.
//

import SwiftUI
import Waveform
import AVFoundation

struct WaveView2: View {
    @Binding var isEdit: Bool
    
    @State var width: CGFloat = -10
    @State var width1: CGFloat = 622
    
    @State var generator = WaveformGenerator(audioFile: try! AVAudioFile(forReading: RecordController.sharedInstance.getUrl()))!
    @State var selectedSamples = 0..<1
    
    @State var sliderPosition: ClosedRange<Float> = 0...1
    
    
    @State var playTimer = 0.0
    @State var player: AVAudioPlayer!
    @State var duration = 0.0
    @State var endTime = 0.0
    @State var isPlaying = false
    @State var endWidth = 0.0
    @State var timerWidth = 0.0
    @State var isStart = false
    
    var body: some View {
        VStack {
            
            VStack {
               
                Waveform(generator: generator, selectedSamples: $selectedSamples, selectionEnabled: .constant(false))
                    .layoutPriority(1)
                    .foregroundColor(Color.green)
                    .background(Color.clear)
                    .accentColor(Color.green)
                    .frame(width: 650, height: 200)
                
                RangeSlider(width: self.$width, width1: self.$width1, endWidth: self.$endWidth)
                
                HStack {
                    
                    Button( action: {
                        if(!self.player.isPlaying) {
                            print("play")
//                            self.player.play(atTime: playTime)
                            self.endWidth = 0.0
                            
                            let end = 688 - (622 - self.width1)
//                            print("end : \(end)")
                            let start = 38 + (self.width + 10)
                            let timePercent = (self.width + 10) / 650
                            var startTime = self.duration * timePercent
                            
                            if(startTime == 0.0) {
                                startTime = 0.01
                            }
                            self.player.currentTime = startTime
                            
                            let endTimePercent = (650 - (622 - self.width1)) / 650
                            self.endTime = self.duration * endTimePercent
                            
                            let playWidth = (688 - (622 - self.width1)) - (38 + (self.width + 10))
//                            let playPercent = playWidth / 650
//                            print("playPercent : \(playPercent)")
                            
                            let playTime = self.endTime - startTime
//                            print("playTime : \(playTime)")
                            self.timerWidth = playWidth / (playTime * 100)
                            
                            self.player.play()
                            
                            self.isPlaying = true
                        } else {
                            print("playing")
                        }
                    } ) {
                        Text("play")
                    }
                    
                    Button( action : {
                        if(self.player.isPlaying) {
                            print("stop")
//                            self.playTime = self.player.currentTime
                            self.player.stop()
                            
                            self.isPlaying = false
                            self.endWidth = 0.0
                        } else {
                            print("stopping")
                        }
                    }) {
                        Text("stop")
                    }
                    
                    Button( action: {
                        print("save")
                    }) {
                        Text("save")
                    }
                    
                } // HStack
                
                Button( action: {
                        self.isEdit.toggle()
                    }) {
                        Text("end")
                    }
                    .onAppear{
                        print("recording view")
                    }
                
            }   // VStack
            .onAppear{
                selectedSamples = 0..<Int(generator.audioBuffer.frameLength)
                do {
                    self.player = try AVAudioPlayer(contentsOf: RecordController.sharedInstance.getUrl())
//                    self.player.prepareToPlay()
                } catch {
                    print(error.localizedDescription)
                }
                self.duration = self.player.duration
                
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (_) in
//                    print(RecordController.sharedInstance.getUrl())
                    if(self.isPlaying) {
                        print("------------------------------")
                        print("self.player.currentTime : \(self.player.currentTime)")
                        print("self.endTime : \(self.endTime)")
                                                
                        if(self.player.currentTime >= self.endTime) {
                            
                            print("over")
                            if(self.player.isPlaying) {
                                self.player.stop()
                            }
                            
                            self.isPlaying = false
                        }
                        
                        if(isStart && self.player.currentTime == 0.0) {
                            self.isStart = false
                            self.isPlaying = false
                        }
                        
                        if(!isStart && self.player.currentTime == 0.0) {
                            isStart = true
                        }
                        
                        
                        self.endWidth += self.timerWidth
                        
//                        if(!isStart && self.player.currentTime == 0.0) {
//                            isStart = true
//                        } else if(isStart && self.player.currentTime == 0.0) {
//
//                        }
                        
                        
                        
                        
                    } else {
                        print("stop")
                    }
                }
                
            }
            .offset(y: 50)
            
            
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 650, height: 200)
//                .opacity(0.1)
//                .offset(y: -170)
            Path { path in
                path.move(to: CGPoint(x:38 + (self.width + 10), y: 0))
                path.addLine(to: CGPoint(x: 38 + (self.width + 10), y: 210))
                path.addLine(to: CGPoint(x: 688 - (622 - self.width1) + 10, y: 210))
                path.addLine(to: CGPoint(x:688 - (622 - self.width1) + 10, y:0))
                path.closeSubpath()
            }
            .fill(Color.green)
            .opacity(0.1)
            .offset(y: -240)
            
            Path { path in
                path.move(to: CGPoint(x:38 + (self.width + 10), y: 0))
                path.addLine(to: CGPoint(x: 38 + (self.width + 10), y: 210))
                
                
                path.addLine(to: CGPoint(x: 38 + (self.width + 10) + self.endWidth, y: 210))
                path.addLine(to: CGPoint(x: 38 + (self.width + 10) + self.endWidth, y:0))
                path.closeSubpath()
            }
            .fill(Color.blue)
            .opacity(0.1)
            .offset(y: -270)
            
            
        }   // ZStack
        
        
            
    }
}

struct RangeSlider: View {
    
//    @State var width : CGFloat = 0
//    @State var width1: CGFloat = 622
    
    @Binding var width: CGFloat
    @Binding var width1: CGFloat
    @Binding var endWidth: Double
    
    var body: some View {
        VStack {
            ZStack (alignment: .leading){
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(width: 650 ,height: 6)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: self.width1 - self.width + 30, height: 6)
                    .offset(x: self.width)
                
                HStack (spacing: 0){
                    Circle()
                        .fill(Color.green)
                        .frame(width: 25, height: 25)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if(value.location.x >= 0 && value.location.x <= self.width1) {
                                        self.width = value.location.x
                                        print("width : \(self.width)")
                                        self.endWidth = 0.0
                                        
                                        
                                    }
                                })
                        )
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 25, height: 25)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if(value.location.x <= 622 && value.location.x >= self.width) {
                                        self.width1 = value.location.x

                                        print("width1 : \(self.width1)")
                                        self.endWidth = 0.0
                                    }
                                })
                        )
                    
                }   // HStack
            }   // ZStack
        }   // VStack
    }
}
