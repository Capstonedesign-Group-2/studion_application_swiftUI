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
    
    var body: some View {
        VStack {
            
            VStack {
               
                Waveform(generator: generator, selectedSamples: $selectedSamples, selectionEnabled: .constant(false))
                    .layoutPriority(1)
                    .foregroundColor(Color.green)
                    .background(Color.clear)
                    .accentColor(Color.green)
                    .frame(width: 650, height: 200)
                
                RangeSlider(width: self.$width, width1: self.$width1)
                
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
            }
            .offset(y: 50)
            
            
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 650, height: 200)
//                .opacity(0.1)
//                .offset(y: -170)
            Path { path in
                path.move(to: CGPoint(x:38 + (self.width + 10), y: 0))
                path.addLine(to: CGPoint(x: 38 + (self.width + 10), y: 220))
                path.addLine(to: CGPoint(x: 688 - (622 - self.width1), y: 220))
                path.addLine(to: CGPoint(x:688 - (622 - self.width1), y:0))
                path.closeSubpath()
            }
            .fill(Color.green)
            .opacity(0.1)
            .offset(y: -220)
            
            
        }   // ZStack
        
        
            
    }
}

struct RangeSlider: View {
    
//    @State var width : CGFloat = 0
//    @State var width1: CGFloat = 622
    
    @Binding var width: CGFloat
    @Binding var width1: CGFloat
    
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
                                    }
                                })
                        )
                    
                }   // HStack
            }   // ZStack
        }   // VStack
    }
}
