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
                            Image(systemName: self.isPlaying ? "pause.fill" : "play.fill").font(.title)
                                .foregroundColor(Color("mainColor"))
                        }
                        
                        Button( action: {
                            
                            if self.isRecording {
                                
                                Task {
                                    do {
                                        let file = try await AudioEngineController.sharedInstance.stopRecord()
                                        
                                        recordURL.append(file)
                                        self.isRecording = false
                                        
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
                            }
                            
                        } ) {
                            Text(self.isRecording ? "ストップ" : "録音開始")
                                .foregroundColor(self.isRecording ? Color.red.opacity(0.5) : Color("mainColor3"))
                            
//                            Spacer()
                        }
                        
                        if recordURL.count != 0 {
                            VStack {
                                ForEach(0..<recordURL.count, id: \.self) { index in
                                    Button( action : {
                                        
                                        RecordController.sharedInstance.setUrl(url: recordURL[index])
                                        
                                        self.isEdit = true
                                        
                                    }) {
                                        Text("録音ファイル : \(index + 1)")
                                            .sheet(isPresented: $isEdit) {
                                                WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
                                            }
                                            
                                    }
                                }
                                    
                            }
                        }
                        
                        
                        
                    } // HStack
                    
                    
                } // VStack
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                .onAppear{
                    roomUser = [composers]
                }
                
            }// zS
            
        } // geo
    }
}
