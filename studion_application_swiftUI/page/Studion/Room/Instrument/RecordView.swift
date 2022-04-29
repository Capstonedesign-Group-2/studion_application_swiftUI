//
//  RecordView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import SwiftUI
import SwiftUIX
import AVFoundation

struct RecordView: View {
    
    let recordController = RecordController()
    
    @Binding var recordFiles:[URL?]
    @Binding var recordFilesPlayCheck: [Bool?]
    @Binding var recordFilesCurrentTime: [Double?]
    
    var body: some View {
        
        VStack {
            
                if recordFiles.count == 0 {
                    
                    Text("아직 파일이 읎어")
                    
                } else {
                    Spacer()
                        .frame(height: 50)
                    ScrollView {
                            VStack {
                                ForEach(0..<recordFiles.count , id: \.self) {index in
            //                        Button( action : {
            //                            AudioEngineController.sharedInstance.recordingPlayer(url: recordFiles[index]!)
            //                        }) {
            //                            Text("record \(index)")
            //                        }
                                    
                                    HStack {
                                        
                                        VStack {
                                            Image("record-rm")
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                            
                                            Text("record - \((recordFiles.count-1) - index)")
                                        }   // VStack
                                        
                                        Spacer()
                                            .frame(width: 10)
                                        
                                        VStack {
                                            ZStack(alignment: .leading) {
                                                Capsule().fill(Color.black.opacity(0.08)).frame(width: 300, height: 8)
                                                
                                                Capsule().fill(Color.green).frame(width: recordFilesCurrentTime[(recordFiles.count-1) - index]!, height: 8)
                                            }   // ZStack
                                            
                                            
                                            
                                            HStack (spacing: 300 / 3 - 30){
                                                
                                                
                                                
                                                Button(action : {}) {
                                                    Image(systemName: "gobackward.15")
                                                        .font(.title)
                                                }
                                                
                                                
                                                Button(action : {
                                                    
                                                    if(self.recordFilesPlayCheck[(recordFiles.count-1) - index]! == false) {
                                                        AudioEngineController.sharedInstance.recordingPlayer(url: recordFiles[(recordFiles.count-1) - index]!)
                                                        
                                                        self.recordFilesPlayCheck[(recordFiles.count-1) - index]! = true
                                                        
                                                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                                                            
                                                        }
                                                        
                                                    } else {
                                                        
                                                    }
                                                    
                                                }) {
                                                    Image(systemName: self.recordFilesPlayCheck[(recordFiles.count-1) - index]! ?  "pause.fill": "play.fill")
                                                        .font(.title)
                                                }
                                                
                                                Button(action : {}) {
                                                    Image(systemName: "goforward.15")
                                                        .font(.title)
                                                }
                                                
                                                                                                
                                            }   //HStack
                                            .padding(.top, 5)
                                            .foregroundColor(.black)
                                            
                                        }   // VStack
                                        
                                        
                                        
                                        
                                        
                                    }   // HStack
                                    
                                    
                                
                            }   // ForEach
                        }   // VStack
                    }   // ScrollView
                    
                    
                
                
            }
        
        }   // VStack
    
    
    }
}
