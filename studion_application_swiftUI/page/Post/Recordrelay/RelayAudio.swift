//
//  RelayAudio.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/05/18.
//

import SwiftUI
import AVKit
import AVFoundation

struct RelayAudio: View {
    
    var audioURLString: String
    @State var playerItem: AVPlayerItem?
    @State var player = AVPlayer()
    @State var isPlaying: Bool = false
    
    
    @State var recordURL: [URL] = []
    @State var isRecording: Bool = false
    
    @State var audioPlayer: AVAudioPlayer!
    
    @State var isEdit = false
    
    var composers:[Any]?
    
    @State var roomUser: [Any] = []
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                VStack {
                    
                    
                    VStack {
                    
                        RelayAudioView(audioURL: audioURLString, isPlaying: $isPlaying)
                                .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
                                .padding(.horizontal , 150)
                                .padding(.vertical, 50)
                        
                            
                            Button( action: {
                                
                                if self.isRecording {
                                    
                                    Task {
                                        do {
                                            let file = try await AudioEngineController.sharedInstance.stopRecord()
                                            
                                            recordURL.append(file)
                                            self.isRecording = false
                                            self.isPlaying = false
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                } else {
                                    do {
                                        try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: .mixWithOthers)
                                        try AVAudioSession.sharedInstance().setActive(true)
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    AudioEngineController.sharedInstance.startRecord() { data in
                                        
                                    }
                                    
                                    self.isRecording = true
                                    self.isPlaying = true
                                }
                                
                            } ) {
                                
                                Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .font(.largeTitle)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(isRecording ? .red.opacity(0.5) : Color("mainColor"))
                            }
                        
                        
                    } // HStack
                        
                        if recordURL.count != 0 {
                            HStack {
                                ForEach(0..<recordURL.count, id: \.self) { index in
                                    Button( action : {
                                        
                                        RecordController.sharedInstance.setUrl(url: recordURL[index])
                                        
                                        self.isEdit = true
                                        
                                    }) {
                                        Image(systemName: "mic.fill")
                                            .foregroundColor(Color("mainColor3"))
                                            .padding()
                                        
                                        Text("\(index + 1)")
                                            .foregroundColor(Color("mainColor3"))
                                            .padding()
                                            .sheet(isPresented: $isEdit) {
                                                WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
                                            }
                                            
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("mainColor"), lineWidth: 1)
                                    )
                                }
                            }// hS
                        }
                        
                    
                    
                } // VStack
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                .onAppear{
                    roomUser = [composers]
                }
                
            }// zS
            
        } // geo
    }
}
