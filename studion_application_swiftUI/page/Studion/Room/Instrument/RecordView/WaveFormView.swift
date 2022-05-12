//
//  AudioPlayerView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/05/02.
//

import SwiftUI
import AVFoundation
import Waveform

struct WaveFormView: View {
    
    @StateObject var generator = WaveformGenerator(audioFile: try! AVAudioFile(forReading: RecordController.sharedInstance.getUrl()))!
    @State var generatorCheck = false
    @State var showSheet = false
    @State var selectedSamples = 0..<1
    
    var body: some View {
        
        VStack {
            Waveform(generator: generator, selectedSamples: $selectedSamples, selectionEnabled: .constant(true))
                .foregroundColor(.primary)
                .background(.clear)
                .accentColor(.accentColor)
//            Text("AAAAA")
            
        }
        .onAppear{
            selectedSamples = 0..<Int(generator.audioBuffer.frameLength)
        }
    }
}

