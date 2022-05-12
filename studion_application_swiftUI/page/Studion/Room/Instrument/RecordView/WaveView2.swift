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
    @State var generator = WaveformGenerator(audioFile: try! AVAudioFile(forReading: RecordController.sharedInstance.getUrl()))!
    @State var selectedSamples = 0..<1
    
    var body: some View {
        VStack {
            Waveform(generator: generator, selectedSamples: $selectedSamples, selectionEnabled: .constant(false))
            
            
                .layoutPriority(1)
                .foregroundColor(Color.primary)
                .background(Color.yellow)
                .accentColor(Color.black)
                .frame(width: 300, height: 100)
            
            
        }
        .onAppear{
            selectedSamples = 0..<Int(generator.audioBuffer.frameLength)
            
        }
        
            
    }
}



