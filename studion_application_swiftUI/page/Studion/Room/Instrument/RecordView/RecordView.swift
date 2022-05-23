//
//  RecordView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import SwiftUI
import AVFoundation
import AVKit

struct RecordView: View {
    
//    let recordController = RecordController()
    
    @Binding var recordFiles:[URL?]
    
    @Binding var recordFilesPlayCheck: [Bool?]
    @Binding var recordFilesCurrentTime: [Double?]
    @Binding var recordFilesVolume: [URL?]
    
    @State var player : AVAudioPlayer!
    @State var isPlaying: Bool = false
    
//    private let waveformImageDrawer = WaveformImageDrawer()
    @State var image: UIImage?
        
    @State var isEdit = false
    
    
    @State var audioURL: URL?
    @State var showingAudioPicker = false
    
    @State var avkitPlayer = AVPlayer()
    @State var playerItem: AVPlayerItem?
    
    var roomUser: [Any]
    
    
    var body: some View {
        
        VStack {
            
                if recordFiles.count == 0 {
                    
                    Text("아직 파일이 읎어")
                    
                } else {
                    Spacer()
                        .frame(height: 50)
                    
                    if UIDevice.isIpad {
                        
                        ScrollView {
                                VStack {
                                    ForEach(0..<recordFiles.count , id: \.self) {index in

                                        HStack {
                                            
                                            VStack {
                                                Button(action : {
                                                    
                                                    if(self.player!.isPlaying) {
                                                        self.player!.stop()
                                                    } else {
                                                        do {
                                                            self.player! = try AVAudioPlayer(contentsOf: self.recordFiles[(recordFiles.count-1) - index]!)
                                                            self.player!.play()
                                                        } catch {
                                                            print(error.localizedDescription)
                                                        }
                                                    }
                                                    
                                                    
                                                }) {
                                                    Image("record-rm")
                                                        .resizable()
                                                        .frame(width: 400, height: 400)
                                                }
                                            
                                                
                                                
                                                Text("record - \((recordFiles.count-1) - index + 1)")
                                                    .font(.largeTitle).fontWeight(.bold)
                                                    .foregroundColor(Color("mainDark"))
                                                    .frame(width: 400)
                                                    .onTapGesture {
                                                        RecordController.sharedInstance.setUrl(url: recordFiles[(recordFiles.count-1) - index]!)
                                                        self.isEdit.toggle()
                                                    }
                                                    .sheet(isPresented: $isEdit) {
                                                        VStack {
                                                                                                            
                                                            WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
                                                            
                                                        }
                                                    }
                                            }   // VStack
                                            
                                            Spacer()
                                                .frame(width: 50)
                                            
//                                            Button( action: {
//
//                                                RecordController.sharedInstance.setUrl(url: recordFiles[(recordFiles.count-1) - index]!)
//
//
//                                                self.isEdit.toggle()
//                                            }) {
//                                                Text("edit")
//                                                    .font(.title3).fontWeight(.semibold)
//                                                    .foregroundColor(Color("mainColor3"))
//                                            }
//                                            .sheet(isPresented: $isEdit) {
//                                                VStack {
//
//                                                    WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
//
//                                                }
//                                            }
                                            
                                            
                                        }   // HStack
                                }   // ForEach
                            }   // VStack
                        }   // ScrollView
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                    } else {
                        ScrollView {
                                VStack {
                                    ForEach(0..<recordFiles.count , id: \.self) {index in

                                        HStack {
                                            
                                            VStack {
                                                Button(action : {
                                                    
                                                    if(self.player!.isPlaying) {
                                                        self.player!.stop()
                                                    } else {
                                                        do {
                                                            self.player! = try AVAudioPlayer(contentsOf: self.recordFiles[(recordFiles.count-1) - index]!)
                                                            self.player!.play()
                                                        } catch {
                                                            print(error.localizedDescription)
                                                        }
                                                    }
                                                    
                                                    
                                                }) {
                                                    Image("record-rm")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                }
                                                .sheet(isPresented: $isEdit) {
                                                    VStack {
                                                                                                        
                                                        WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
                                                        
                                                    }
                                                }
                                                
                                                
                                                Text("record - \((recordFiles.count-1) - index + 1)")
                                                    .foregroundColor(Color("mainDark"))
                                                    .frame(width: 100)
                                                    .onTapGesture {
                                                        RecordController.sharedInstance.setUrl(url: recordFiles[(recordFiles.count-1) - index]!)
                                                        self.isEdit.toggle()
                                                    }
                                            }   // VStack
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            

                                            
                                            
                                                                                    
//                                            Button( action: {
//
//                                                RecordController.sharedInstance.setUrl(url: recordFiles[(recordFiles.count-1) - index]!)
//
//
//                                                self.isEdit.toggle()
//                                            }) {
//                                                Text("edit")
//                                                    .font(.title3).fontWeight(.semibold)
//                                                    .foregroundColor(Color("mainColor3"))
//                                            }
//                                            .sheet(isPresented: $isEdit) {
//                                                VStack {
//
//                                                    WaveView2(isEdit: self.$isEdit, roomUser: roomUser)
//
//                                                }
//                                            }
                                        }   // HStack
                                }   // ForEach
                            }   // VStack
                        }   // ScrollView
                        .frame(width: UIScreen.main.bounds.width)
                    }
                
            }
        
        }   // VStack
        .onAppear{
            let url = Bundle.main.path(forResource: "cr", ofType: "wav")

            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.prepareToPlay()
        }
        
    
    
    }
}

