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
    
    
    var body: some View {
        VStack {
            HStack {
                
                Button( action: {
                    
                    if isPlaying {
                        
                        player.pause()
                        self.isPlaying = false
                        
                    } else {
                        
                        print(audioURLString)
                        let url = URL(string: (audioURLString))
                        print(url)
                        
                        playerItem = AVPlayerItem(url: url!)
                        player.replaceCurrentItem(with: playerItem)
                        
                        player.play()
                        
                        self.isPlaying = true
                        
                    }
                    
                    
                    
                }) {
                    Text(isPlaying ? "멈춤" : "플레이")
                }
                
                Button( action: {
                    
                    if isRecording {
                        
                        Task {
                            do {
                                let file = try await AudioEngineController.sharedInstance.stopRecord()
                                
                                recordURL.append(file)
                                
                                isRecording = false
                                
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
                        
                        isRecording = true
                    }
                    
                } ) {
                    Text(isRecording ? "중지" : "녹음")
                }
                
                if recordURL.count != 0 {
                    VStack {
                        ForEach(0..<recordURL.count, id: \.self) { index in
                            Button( action : {
                                
                                RecordController.sharedInstance.setUrl(url: recordURL[index])
                                
                                self.isEdit = true
                                
                            }) {
                                Text("녹음 : \(index)")
                                    .sheet(isPresented: $isEdit) {
//                                        WaveView2(isEdit: self.$isEdit, roomUser:)
                                    }
                                    
                            }
                        }
                            
                    }
                }
                
                
                
            } // HStack
        } // VStack
    }
}
