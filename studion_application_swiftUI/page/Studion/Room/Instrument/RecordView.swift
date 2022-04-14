//
//  RecordView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import SwiftUI
import AVFoundation

struct RecordView: View {
    
    let recordController = RecordController()
    
    @Binding var recordFiles:[URL]
    
    
    var body: some View {
        
        VStack {
            
            if recordFiles.count == 0 {
                
                Text("아직 파일이 읎어")
                
            } else {
//                ForEach(0..<recordFiles.count , id: \.self) {index in
//                    Button( action : {
//                        print(recordFiles[index])
//                        recordController.play(url: recordFiles[index])
//                    }) {
//                        Text("record \(index)")
//                    }
//                }
            }
            
            
        }
        
    }
    
    
}

